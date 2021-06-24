{ config, pkgs, ... }:

{
  imports = [ ./neovim ./fish ];

  programs.home-manager.enable = true;

  home.username = "kotwys";
  home.homeDirectory = "/home/kotwys";

  home.packages = with pkgs; [
    (vivaldi.override { proprietaryCodecs = true; })
    discord
    tdesktop
    gimp
    inkscape
  ];

  home.sessionVariables = {
    TEXMFHOME = "${config.xdg.dataHome}/texmf";
    TEXMFVAR = "${config.xdg.cacheHome}/texlive/texmf-var";
    TEXMFCONFIG = "${config.xdg.configHome}/texlive/texmf-config";
  };

  programs.bash = { enable = true; };

  programs.git = {
    enable = true;
    ignores = [ "*.swp" ];

    userName = "kotwys";
    userEmail = "52920928+kotwys@users.noreply.github.com";
  };

  programs.gpg.enable = true;
  services.gpg-agent.enable = true;

  xdg.enable = true;

  home.stateVersion = "21.05";
}
