{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./config.vim;
    plug = {
      enable = true;
      plugins = [
        "vim-airline/vim-airline"
        "vim-airline/vim-airline-themes"
        "preservim/nerdtree"

        "tpope/vim-surround"
        "mattn/emmet-vim"

        "editorconfig/editorconfig-vim"

        {
          plugin = "Shougo/denite.nvim";
          options = "{'do': ':UpdateRemotePlugins'}";
        }

        "LnL7/vim-nix"
        "vim-pandoc/vim-pandoc"
        "vim-pandoc/vim-pandoc-syntax"
      ];
      after = builtins.readFile ./plugins.vim;
    };
  };
}
