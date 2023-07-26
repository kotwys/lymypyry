{ lib, stdenv, fetchurl, unzip, glib, expat }:
version: hashes:
let
  pname = "electron-mksnapshot";
  fetcher = vers: tag: hash: fetchurl {
    url = "https://github.com/electron/electron/releases/download/v${vers}/mksnapshot-v${vers}-${tag}.zip";
    sha256 = hash;
  };
  tags = {
    x86_64-linux = "linux-x64";
    armv7l-linux = "linux-armv7l";
    aarch64-linux = "linux-arm64";
    x86_64-darwin = "darwin-x64";
  } // lib.optionalAttrs (lib.versionAtLeast version "11.0.0") {
     aarch64-darwin = "darwin-arm64";
  } // lib.optionalAttrs (lib.versionOlder version "19.0.0") {
    i686-linux = "linux-ia32";
  };
  get = as: platform: as.${platform.system} or (throw "Unsupported system: ${platform.system}");
  libPath = lib.makeLibraryPath [ glib expat ];
in
stdenv.mkDerivation {
  inherit pname version;
  src = fetcher version (get tags stdenv.hostPlatform) (get hashes stdenv.hostPlatform);

  nativeBuildInputs = [ unzip ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/{bin,lib/mksnapshot}
    unzip -d $out/lib/mksnapshot $src
    ln -s $out/lib/mksnapshot/{mksnapshot,v8_context_snapshot_generator} \
      $out/bin
  '';

  postFixup = if stdenv.isDarwin then "" else ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      $out/lib/mksnapshot/mksnapshot

    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}:$out/lib/mksnapshot" \
      $out/lib/mksnapshot/v8_context_snapshot_generator
  '';

  meta = with lib; {
    description = "Cross platform desktop application shell";
    homepage = "https://github.com/electron/electron";
    license = licenses.mit;
    platforms = [ "x86_64-darwin" "x86_64-linux" "armv7l-linux" "aarch64-linux" ]
      ++ optionals (versionAtLeast version "11.0.0") [ "aarch64-darwin" ]
      ++ optionals (versionOlder version "19.0.0") [ "i686-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    knownVulnerabilities = optional (versionOlder version "22.0.0") "Electron version ${version} is EOL";
  };
}
