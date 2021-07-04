{ config, lib, pkgs, ... }:

with lib;

let
  extraXkbOptions = config.services.xserver.extraXkbOptions;

  symbolsType = with types;
    submodule {
      options = {
        bindAs = mkOption {
          description = "ID to bind option to. Defaults to <group>:<symbols>";
          type = nullOr str;
          default = null;
          example = "misc:typo-my";
        };

        include = mkOption {
          description = "Symbols definitions to include.";
          type = listOf str;
          default = [ ];
          example = [ "typo" ];
        };

        keys = mkOption {
          description = "Key definitions.";
          type = attrsOf (listOf str);
          default = { };
          example = literalExample ''
            {
              "AD03" = [ "NoSymbol" "NoSymbol" "EuroSign" "NoSymbol" ];
            }
          '';
        };
      };
    };

  mkInclude = includes: ''include "${concatStringsSep "+" includes}"'';
  mkKey = name: symbols: ''
    key <${name}> { [ ${concatStringsSep ", " symbols} ] };
  '';

  writeSymbols = group: name:
    { bindAs, include, keys }:
    let bindAs' = if bindAs == null then "${group}:${name}" else bindAs;
    in ''
      cat >> symbols/${group} << EOF
      partial alphanumeric_keys xkb_symbols "${name}" {
        ${optionalString (include != [ ]) (mkInclude include)}

        ${concatStringsSep "\n" (mapAttrsToList mkKey keys)}
      };
      EOF

      sed -f- -i rules/0042-o_s.part << EOF
      /! option/a\
      \ \ ${bindAs'} = +${group}(${name})
      EOF
    '';
in {
  options.services.xserver.extraXkbOptions = mkOption {
    description = "Attribute set of option groups";
    type = with types; attrsOf (attrsOf symbolsType);
    default = { };
    example = literalExample ''
      {
        typo-my.base = {
          bindAs = "misc:typo-my";
          includes = [ "typo" ];
          keys.TLDE = [ "NoSymbol" "NoSymbol" "EuroSign" "NoSymbol" ];
        };
      }
    '';
  };

  config = mkIf (extraXkbOptions != { }) {
    nixpkgs.overlays = singleton (self: super: {
      xkb_patched = self.xorg.xkeyboardconfig.overrideAttrs (old: {
        postPatch = concatStringsSep "\n" (flatten
          (mapAttrsToList (group: mapAttrsToList (writeSymbols group))
            extraXkbOptions));
      });

      xorg = super.xorg // {
        xorgserver = super.xorg.xorgserver.overrideAttrs (old: {
          configureFlags = old.configureFlags ++ [
            "--with-xkb-bin-directory=${self.xorg.xkbcomp}/bin"
            "--with-xkb-path=${self.xkb_patched}/share/X11/xkb"
          ];
        });

        setxkbmap = super.xorg.setxkbmap.overrideAttrs (old: {
          postInstall = ''
            mkdir -p $out/share
            ln -sfn ${self.xkb_patched}/etc/X11 $out/share/X11
          '';
        });

        xkbcomp = super.xorg.xkbcomp.overrideAttrs (old: {
          configureFlags =
            [ "--with-xkb-config-root=${self.xkb_patched}/share/X11/xkb" ];
        });

      };

      ckbcomp = super.ckbcomp.override { xkeyboard_config = self.xkb_patched; };

      xkbvalidate = super.xkbvalidate.override {
        libxkbcommon =
          self.libxkbcommon.override { xkeyboard_config = self.xkb_patched; };
      };
    });

    environment.sessionVariables = {
      XKB_CONFIG_ROOT = "${pkgs.xkb_patched}/etc/X11/xkb";
    };

    services.xserver = {
      xkbDir = "${pkgs.xkb_patched}/etc/X11/xkb";
      exportConfiguration =
        config.services.xserver.displayManager.startx.enable;
    };
  };
}
