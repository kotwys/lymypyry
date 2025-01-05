{ stdenv, lib, emacs }:

let
  rev = "ef4d74feb6ccefcfc2306ea7ffc193cc3735f68c";
  themes = {
    motel.sha256 = "0qqy924i6m00y1b3f4l1798a5bglyzdzhd46pjrfc36gdbddg640";
  };
  targets = [ "emacs" "konsole" ];

  mkTheme = { themeName, sha256, target }:
    stdenv.mkDerivation {
      name = "base2tone-${themeName}-${target}-theme";
      src = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/atelierbram/Base2Tone/${rev}/db/schemes/base2tone-${themeName}.yml";
        inherit sha256;
      };

      nativeBuildInputs = [ emacs ];
      phases = [ "buildPhase" ];
      buildPhase = ''
        emacs -q -batch \
            ${./.}/${target}.el --eval="(eval-buffer)" \
            --eval="(generate-theme \"$src\")" > $out
      '';
    };
in
lib.mapAttrs
  (themeName: { sha256 }:
    lib.genAttrs targets (target:
      mkTheme { inherit themeName sha256 target; }
    )
  )
  themes
