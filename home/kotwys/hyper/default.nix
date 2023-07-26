{ pkgs, ... }:

let
  mkTheme = pkgs.callPackage ./base2tone.nix {};
  colors = builtins.fromJSON (builtins.readFile (mkTheme {
    themeName = "motel";
    sha256 = "0qqy924i6m00y1b3f4l1798a5bglyzdzhd46pjrfc36gdbddg640";
  }));

  bell =
    pkgs.runCommand "bell-sound" {
      buildInputs = [ pkgs.ffmpeg ];
    } ''
      ffmpeg \
        -i ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/bell.oga \
        -c:a libmp3lame \
        -f mp3 - | \
        base64 -w 0 > $out
    '';

  config = {
    updateChannel = "canary";
    disableAutoUpdates = true;
    fontFamily = "\"Cascadia Code\", \"JetBrains Mono\", monospace";
    fontSize = 11.6;
    lineHeight = 1.4;
    cursorShape = "BEAM";
    cursorBlink = true;
    cursorColor = colors.green;
    cursorAccentColor = colors.green;
    backgroundColor = colors.black;
    foregroundColor = colors.white;
    selectionColor = "rgba(255,255,255,0.1)";
    bell = "SOUND";
    bellSound = "data:audio/mpeg;base64,${builtins.readFile bell}";
    inherit colors;
    webGLRenderer = false;
    disableLigatures = false;
    imageSupport = true;
    webLinksActivationKey = "ctrl";
  };
in
{
  home.packages = [ pkgs.locals.hyperCanary ];
  xdg.configFile."Hyper/hyper.json".text = builtins.toJSON {
    "$schema" = "./schema.json";
    inherit config;
  };
}
