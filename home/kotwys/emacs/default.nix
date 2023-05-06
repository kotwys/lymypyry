{ pkgs, ... }:

let
  emacs' = (pkgs.emacsPackagesFor pkgs.emacsGit-nox).emacsWithPackages
    (p: builtins.attrValues {
      inherit (p.melpaPackages)
        meow powerline magit yaml company lsp-mode lsp-ui flycheck
        yasnippet clojure-mode rust-mode nix-mode markdown-mode
        treesit-auto;
    });
  mkTheme = pkgs.callPackage ./base2tone.nix { emacs = emacs'; };
in
{
  programs.emacs = {
    enable = true;
    package = emacs';
  };

  xdg.configFile."emacs/init.el".source = ./init.el;
  xdg.configFile."emacs/themes/base2tone-motel-theme.el".source =
    mkTheme {
      themeName = "motel";
      sha256 = "0qqy924i6m00y1b3f4l1798a5bglyzdzhd46pjrfc36gdbddg640";
    };
  xdg.configFile."emacs/conf.d/".source = ./conf.d;
}
