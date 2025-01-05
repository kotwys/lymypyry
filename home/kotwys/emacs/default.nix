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

  treesit-default-grammars = [
    "bash" "c" "c-sharp" "clojure" "cmake" "cpp" "css" "elisp" "html"
    "java" "javascript" "jsdoc" "json" "kotlin" "lua" "nix" "php" "python" "ruby" "rust"
    "toml" "tsx" "typescript" "yaml"
  ];

  emacs' = lib.pipe pkgs.emacs-git [
    pkgs.emacsPackagesFor
    (x: x.emacsWithPackages (ps: builtins.attrValues {
      inherit (ps.melpaPackages)
        meow powerline magit yaml company lsp-mode lsp-ui meson-mode
        flycheck clojure-mode cider rust-mode nix-mode markdown-mode
        haskell-mode treesit-auto bqn-mode git-gutter htmlize
        popwin kotlin-mode atomic-chrome smartparens ligature;
      treesit = ps.treesit-grammars.with-grammars (grammars: (
        lib.attrsets.attrVals
          (map (x: "tree-sitter-${x}") treesit-default-grammars)
          grammars
      ) ++ [tree-sitter-pascal]);
    }))
  ];
  base2tone = pkgs.callPackage ../base2tone { emacs = emacs'; };
  siteLisp = {
    "pascal-ts-mode.el" = ./site-lisp/pascal-ts-mode.el;
    "ttl-mode.el" = pkgs.fetchurl {
      url = "https://github.com/jeeger/ttl-mode/raw/04b86536e0363a78c11ca10ac83096b28fc5fbf0/ttl-mode.el";
      sha256 = "0ha9f4gcmlxmg2vi5krqjx8cnzynrryjr7dpssl1m2p7956m1r80";
    };
  };
in
{
  programs.emacs = {
    enable = true;
    package = emacs';
  };

  xdg.configFile = {
    "emacs/init.el".source = ./init.el;
    "emacs/themes/base2tone-motel-theme.el".source = base2tone.motel.emacs;
    "emacs/conf.d/".source = ./conf.d;
  } // (lib.concatMapAttrs (name: value: {
    "emacs/site-lisp/${name}".source = value;
  }) siteLisp);
}
