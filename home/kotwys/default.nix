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
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent.enable = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
      vscodevim.vim
    ];
    userSettings = {
      "editor.fontFamily" = "Cascadia Code, monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 13;
      "editor.minimap.enabled" = false;
      "editor.smoothScrolling" = true;
      "editor.cursorSmoothCaretAnimation" = true;

      "editor.tabSize" = 2;

      "emmet.includeLanguages" = {
        nunjucks = "html";
      };
    };
  };

  xdg.enable = true;

  home.stateVersion = "21.05";
}
