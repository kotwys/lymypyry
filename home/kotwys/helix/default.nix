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
    inherit themes;
  };
}
