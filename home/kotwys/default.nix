{ config, pkgs, ... }:

let
  base2tone = pkgs.callPackage ./base2tone {
    emacs = config.programs.emacs.package;
  };
in
{
  imports = [ ./zsh ./emacs ];

  programs.home-manager.enable = true;

  home.username = "kotwys";
  home.homeDirectory = "/home/kotwys";

  home.packages = builtins.attrValues {
    inherit (pkgs) yq textql;
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.sessionVariables = {
    TEXMFHOME = "${config.xdg.dataHome}/texmf";
    TEXMFVAR = "${config.xdg.cacheHome}/texlive/texmf-var";
    TEXMFCONFIG = "${config.xdg.configHome}/texlive/texmf-config";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    EDITOR = "emacs";
  };

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      battery.disabled = true;
      format =           "┌ $all";
      character.format = "└ $symbol ";
      character.success_symbol = "[λ](bold green)";
      character.error_symbol =   "[λ](bold red)";
    };
  };

  programs.git = {
    enable = true;
    ignores = [ "*.swp" ];

    userName = "Kočyš Mikajlo";
    userEmail = "52920928+kotwys@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.tmux = {
    enable = true;
    shell = "${config.programs.zsh.package}/bin/zsh";
  };

  home.file.".XCompose".source = ./XCompose;

  xdg.enable = true;
  fonts.fontconfig.enable = false;
  xdg.dataFile."konsole/base2tone-motel.colorscheme" = {
    source = base2tone.motel.konsole;
  };
  xdg.configFile."fontconfig/conf.d/60-system-fonts.conf" = {
    source = ./60-system-fonts.conf;
  };

  home.stateVersion = "21.05";
}
