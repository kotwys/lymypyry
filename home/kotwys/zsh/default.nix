{ ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    initExtra = builtins.readFile ./init.zsh;
    history.ignoreAllDups = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        single-hyphen-option = "fg=blue";
        double-hyphen-option = "fg=blue";
      };
    };
  };
}
