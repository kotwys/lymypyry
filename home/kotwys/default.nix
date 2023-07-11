{ config, pkgs, ... }:

{
  imports = [ ./fish ./helix ./emacs ];

  programs.home-manager.enable = true;

  home.username = "kotwys";
  home.homeDirectory = "/home/kotwys";

  home.packages = builtins.attrValues {
    inherit (pkgs) blackbox-terminal jq textql;
    vivaldi = pkgs.vivaldi.override {
      proprietaryCodecs = true;
    };
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.sessionVariables = {
    TEXMFHOME = "${config.xdg.dataHome}/texmf";
    TEXMFVAR = "${config.xdg.cacheHome}/texlive/texmf-var";
    TEXMFCONFIG = "${config.xdg.configHome}/texlive/texmf-config";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    EDITOR = "emacs";
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
  
  xdg.dataFile."blackbox/schemes/base2tone-motel-dark.json".source =
    pkgs.fetchurl {
      url = https://raw.githubusercontent.com/drkrynstrng/base2tone-tilix/84183625114555fc0b94dbbc533de0f97b973b6b/schemes/base2tone-motel-dark.json;
      sha256 = "07j1bw555aapfvni43y2jwirh4fxhxkkvgxd9ry1w62d1339y0q2";
    };
  
  home.stateVersion = "21.05";
}
