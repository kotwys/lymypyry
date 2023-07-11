{ pkgs, ... }:

let
  mkTheme = pkgs.callPackage ./base2tone.nix {};
  colors = builtins.fromJSON (builtins.readFile (mkTheme {
    themeName = "motel";
    sha256 = "0qqy924i6m00y1b3f4l1798a5bglyzdzhd46pjrfc36gdbddg640";
  }));
  config = {
    disableAutoUpdates = true;
    fontFamily = "\"Cascadia Code\", \"JetBrains Mono\", monospace";
    fontSize = 11.6;
    lineHeight = 1.4;
    webGLRenderer = false;
    disableLigatures = false;
    cursorShape = "BEAM";
    cursorBlink = true;
    cursorColor = colors.green;
    cursorAccentColor = colors.green;
    backgroundColor = colors.black;
    foregroundColor = colors.white;
    inherit colors;
  };
in
{
  home.packages = [ pkgs.hyper ];
  xdg.configFile."hyper/.hyper.js".text = ''
module.exports = {
  config: ${builtins.toJSON config},
};
'';
}
