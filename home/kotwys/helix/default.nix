{ pkgs, ... }:

let
  themes = import ./base2tone.nix;
in
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "base2tone-motel";
      editor.cursor-shape = {
        normal = "bar";
        insert = "bar";
        select = "block";
      };
    };
    languages = [
      {
        name = "pascal";
        language-server.command =
          "${pkgs.locals.pascal-language-server}/bin/pasls";
      }
    ];
    inherit themes;
  };

  home.packages = [
    pkgs.locals.pascal-language-server
  ];
}
