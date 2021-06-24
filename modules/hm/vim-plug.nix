{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.neovim.plug;

  plugin = types.submodule {
    options = {
      plugin = mkOption {
        type = types.str;
        description = "Plugin identifier";
      };
      options = mkOption {
        type = with types; nullOr str;
        default = null;
        description = "Options for the Plug";
      };
    };
  };

  normalize = p:
    if p ? plugin then
      p
    else {
      plugin = p;
      options = null;
    };

  plug = { plugin, options }:
    "Plug '${plugin}'" + lib.optionalString (options != null) ", ${options}";
in {
  options.programs.neovim.plug = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "vim-plug plugin manager";
    };

    distributable = mkOption {
      type = types.path;
      default = builtins.fetchurl {
        url =
          "https://raw.githubusercontent.com/junegunn/vim-plug/fc2813ef4484c7a5c080021ceaa6d1f70390d920/plug.vim";
        sha256 = "1b1ayy2gsnwgfas5rla2y3gjyfsv1cai96p9jbmap4cclpl9ky97";
      };
      description = "vim-plug package";
      example = ''
        builtins.fetchurl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
      '';
    };

    directory = mkOption {
      type = types.str;
      default = "${config.xdg.configHome}/nvim/plugged";
      description = "Directory for plugins";
      example = "\${config.xdg.configHome}/nvim/plugged";
    };

    plugins = mkOption {
      type = with types; listOf (either str plugin);
      default = [ ];
      description = "List of plugins to use";
    };

    after = mkOption {
      type = types.lines;
      default = "";
      description = "Config to add after loading the plugins";
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "nvim/autoload/plug.vim".source = cfg.distributable;
      "nvim/init.vim".text = mkAfter ''
        source ${config.xdg.configHome}/nvim/_plugins.vim
        ${cfg.after}
      '';
      "nvim/_plugins.vim" = {
        text = ''
          call plug#begin('${cfg.directory}')
          ${builtins.concatStringsSep "\n"
          (map (p: plug (normalize p)) cfg.plugins)}
          call plug#end()
        '';
      };
    };
  };
}
