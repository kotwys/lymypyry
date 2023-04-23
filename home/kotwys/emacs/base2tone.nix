{ stdenv, emacs }:
{ themeName, sha256 }:

stdenv.mkDerivation {
  name = "emacs-${themeName}-theme";
  src = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/atelierbram/Base2Tone/master/db/schemes/base2tone-${themeName}.yml";
    inherit sha256;
  };

  nativeBuildInputs = [ emacs ];
  phases = ["buildPhase"];
  buildPhase = ''
    emacs -q -batch \
          --load=${./base2tone.el} \
          --eval="(generate-theme \"$src\")" > $out
  '';
}
