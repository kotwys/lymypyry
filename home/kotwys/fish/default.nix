{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./colors.fish;
  };
}
