{ pkgs, lib, ... }:

let
  tree-sitter-pascal = pkgs.tree-sitter.buildGrammar {
    language = "tree-sitter-pascal";
    version = "0.9.1";
    src = pkgs.fetchgit {
      url = "https://github.com/Isopod/tree-sitter-pascal";
      rev = "9e995404ddff8319631d72d4b46552e737206912";
      sha256 = "0q3j3a7x42wqi9dkyvwa0hp1n0p7s9l4ijrsks0fgrvmasflzk6b";
    };
  };

  emacs' = lib.pipe pkgs.emacsGit-nox [
    (x: x.override (old: {
      treeSitterPlugins = old.treeSitterPlugins ++ [
        tree-sitter-pascal
      ];
    }))
    pkgs.emacsPackagesFor
    (x: x.emacsWithPackages(p: builtins.attrValues {
      inherit (p.melpaPackages)
        meow powerline magit yaml company lsp-mode lsp-ui meson-mode
        flycheck yasnippet clojure-mode rust-mode nix-mode markdown-mode
        treesit-auto;
    }))
  ];
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
  xdg.configFile."emacs/site-lisp/".source = ./site-lisp;
}
