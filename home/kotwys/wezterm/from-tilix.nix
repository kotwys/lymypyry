{ stdenv, yq }:
{ name, src }:

stdenv.mkDerivation {
  name = "wezterm-theme-${builtins.replaceStrings [" "] ["_"] name}";
  inherit src;

  nativeBuildInputs = [ yq ];
  phases = [ "buildPhase" ];
  buildPhase = ''
    tomlq --slurpfile c $src -n -t '$c[0] | {
      colors: {
        ansi: .palette[0:8],
        background: .["background-color"],
        brights: .palette[8:16],
        cursor_bg: .["cursor-background-color"],
        cursor_border: .["cursor-foreground-color"],
        cursor_fg: .["cursor-foreground-color"],
        foreground: .["foreground-color"],
        selection_bg: .["highlight-background-color"],
        selection_fg: .["highlight-foreground-color"],
        indexed: {},
      },
      metadata: {
        name: "${name}",
      },
    }' > $out
  '';
}
