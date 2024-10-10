{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    initExtra = ''
      setopt auto_pushd
      setopt pushd_ignore_dups
    '';
    completionInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-zA-Zа-яёА-ЯЁ}={A-Za-zА-ЯЁа-яё}'
      zstyle ':completion:*' menu select
    '';
    history.ignoreAllDups = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };
    syntaxHighlighting = {
      enable = true;
      styles = {
        single-hyphen-option = "fg=blue";
        double-hyphen-option = "fg=blue";
      };
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
        file = "zsh-autosuggestions.zsh";
      }
    ];
  };
}
