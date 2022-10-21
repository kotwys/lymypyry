{ config, pkgs, ... }:

{
  imports = [ ./neovim ./fish ./helix ];

  programs.home-manager.enable = true;

  home.username = "kotwys";
  home.homeDirectory = "/home/kotwys";

  home.packages = with pkgs; [
    (vivaldi.override { proprietaryCodecs = true; })
    jq textql
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.sessionVariables = {
    TEXMFHOME = "${config.xdg.dataHome}/texmf";
    TEXMFVAR = "${config.xdg.cacheHome}/texlive/texmf-var";
    TEXMFCONFIG = "${config.xdg.configHome}/texlive/texmf-config";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };

  programs.bash.enable = true;

  programs.git = {
    enable = true;
    ignores = [ "*.swp" ];

    userName = "kotwys";
    userEmail = "52920928+kotwys@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  programs.vscode.enable = true;

  home.file.".XCompose".source = ./XCompose;

  xdg.enable = true;

  home.stateVersion = "21.05";
}
