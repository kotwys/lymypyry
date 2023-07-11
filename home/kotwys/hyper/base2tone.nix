{ stdenv, yq }:
{ themeName, sha256 }:

stdenv.mkDerivation {
  name = "hyper-theme-base2tone-${themeName}";
  src = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/atelierbram/Base2Tone/master/db/schemes/base2tone-${themeName}.yml";
    inherit sha256;
  };

  buildInputs = [ yq ];
  phases = [ "buildPhase" ];
  buildPhase = ''
    yq '{
      black: .baseA0,
      red: .baseB2,
      green: .baseD4,
      yellow: .baseD7,
      blue: .baseB3,
      magenta: .baseD4,
      cyan: .baseB4,
      white: .baseA6,
      lightBlack: .baseA3,
      lightRed: .baseD5,
      lightGreen: .baseD4,
      lightYellow: .baseD7,
      lightBlue: .baseB3,
      lightMagenta: .baseD4,
      lightCyan: .baseD3,
      lightWhite: .baseB7
    } | map_values("#"+.)' "$src" > "$out"
  '';
}
