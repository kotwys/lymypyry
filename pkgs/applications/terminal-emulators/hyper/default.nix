{ stdenv, lib, fetchFromGitHub, makeWrapper, makeDesktopItem, mkYarnModules
, runCommand, wrapGAppsHook, atomEnv, nodejs, yarn, electron
, electron-mksnapshot, python3, libxkbcommon, glib, gtk3
, version, sha256
}:

assert electron.version == electron-mksnapshot.version;

let
  isCanary = lib.hasInfix "canary" version;
  python' = python3.withPackages (ps: [ ps.icnsutil ps.pillow ]);
  npm_config_arch = "x64";
  extractedElectronHeaders =
    runCommand "electron-headers-${electron.version}" {} ''
      mkdir $out && cd $out
      tar -xzf ${electron.headers}
    '';

  src = fetchFromGitHub {
    owner = "vercel";
    repo = "hyper";
    rev = "v${version}";
    inherit sha256;
  };
  mainModules = mkYarnModules {
    pname = "hyper-modules";
    inherit version;
    packageJSON = src + "/package.json";
    yarnLock = src + "/yarn.lock";
    pkgConfig.electron-mksnapshot = {
      postInstall = ''
        sed -i '/const temp = require/s/\.track()//' mksnapshot.js
        cp -Tr "${electron-mksnapshot}/lib/mksnapshot" ./bin
        chmod -R 'u+w' ./bin
      '';
    };
  };
  appModules = mkYarnModules {
    pname = "hyper-app";
    inherit version;
    packageJSON = src + "/app/package.json";
    yarnLock = src + "/app/yarn.lock";
  };

  findExcludeNames = lib.concatMapStringsSep " -o " (x: "-name '${x}'");
  appExcludePatterns = [
    "*.md" "*.ts" ".*rc" "*.cc" "*.c" "*.hh" "*.h" "*.py" "*.bat" "*.ps1" "*.gypi"
    "binding.gyp" "*.o" "*.mk" ".editorconfig" ".eslintrc" ".gitattributes"
    ".nycrc" ".travis.yml" ".npmignore" "yarn-error.log" "yarn.lock" ".yarn_integrity"
    "*Makefile"
  ];

  electronLibPath = lib.makeLibraryPath [ libxkbcommon ];

  desktopItem = makeDesktopItem {
    name = "hyper";
    desktopName = "Hyper" + lib.optionalString isCanary " (Canary)";
    comment = "A terminal built on web technologies";
    categories = [ "TerminalEmulator" ];
    mimeTypes = [ "x-scheme-handler/ssh" ];
    exec = "@hyper@ %U";
    terminal = false;
    startupWMClass = "Hyper";
    icon = "hyper";
  };
in
stdenv.mkDerivation {
  pname = "hyper";
  inherit version src;

  buildInputs = [ nodejs yarn python' glib gtk3 ];
  nativeBuildInputs = [ makeWrapper wrapGAppsHook ];

  YARN = "yarn --offline";
  inherit npm_config_arch;

  dontWrapGApps = true;

  configurePhase = ''
    mkdir -p ./target

    # Create a writable copy of node_modules
    cp -Tr ${mainModules}/node_modules ./node_modules
    cp -Tr ${appModules}/node_modules ./target/node_modules
    chmod -R '+w' ./node_modules ./target/node_modules
    ln -rs ./target/node_modules ./app/node_modules

    cp app/package.json target/
  '';

  buildPhase = ''
    node bin/mk-snapshot.js
    # Check that the snapshot is indeed created
    test $(ls cache/${npm_config_arch} | wc -l) -gt 0
    $YARN node-gyp rebuild -C ./target/node_modules/node-pty \
      --runtime=electron \
      --target=${electron.version} \
      --arch=${npm_config_arch} \
      --nodedir=${extractedElectronHeaders}/node_headers \
      --build-from-source
    $YARN webpack --config-name hyper-app
    $YARN generate-schema
    $YARN build
    rm ./target/yarn.lock
  '';

  installPhase = ''
    # Remove unneeded files from node_modules
    find target/node_modules/ \
      \! \( -type f -o -type d \) -print0 \
      -o -type d \( -name '.bin' -o -name '.github' \) -prune -print0 \
      -o -type f \( ${findExcludeNames appExcludePatterns} \) -print0 | \
      xargs -0 -n 10 rm -r

    mkdir -p $out/{bin,lib/electron,share/applications}
    substitute {${desktopItem},$out}/share/applications/hyper.desktop \
      --subst-var-by hyper "$out/bin/hyper"
    icons=$(mktemp -d)
    icnsutil extract -o $icons -c build/${if isCanary then "canary" else "icon"}.icns
    for icon in $icons/*.png; do
      size=$(basename -s .png $icon)
      mkdir -p $out/share/icons/hicolor/$size/apps
      mv $icon $out/share/icons/hicolor/$size/apps/hyper.png
    done

    cp -Tr ${electron}/lib/electron $out/lib/electron
    chmod -R '+w' $out/lib/electron
    mv $out/lib/electron/{.electron-wrapped,hyper}

    cp cache/${npm_config_arch}/{snapshot_blob.bin,v8_context_snapshot.bin} $out/lib/electron/
    rm $out/lib/electron/resources/default_app.asar
    $YARN asar pack ./target $out/lib/electron/resources/app.asar \
      --unpack-dir "node_modules/{native-process-working-directory,native-reg,node-pty}"
    mkdir -p $out/lib/electron/resources/bin
    cp build/linux/hyper* bin/cli.js $out/lib/electron/resources/bin
    substitute bin/yarn-standalone.js $out/lib/electron/resources/bin/yarn-standalone.js \
      --replace "/usr/bin/env node" "${nodejs}/bin/node"
    ln -s $out/lib/electron/hyper $out/bin/
  '';

  postFixup = ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${atomEnv.libPath}:${electronLibPath}:$out/lib/electron" \
      $out/lib/electron/{hyper,chrome_crashpad_handler}
    wrapProgram $out/lib/electron/hyper "''${gappsWrapperArgs[@]}"
  '';

  meta = with lib; {
    description = "A terminal built on web technologies";
    homepage = "https://hyper.is/";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
}
