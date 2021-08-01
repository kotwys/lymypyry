{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./colors.fish;
  };

  programs.starship = {
    enable = true;
    settings = {
      battery.disabled = true;
    };
  };
}
