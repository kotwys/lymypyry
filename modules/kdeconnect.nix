{ config, lib, pkgs, ... }:

with lib;

let cfg = config.services.kdeconnect;
in {
  options.services.kdeconnect = {
    enable = mkEnableOption
      "KDE Connect provides several features to integrate your phone and your computer";
    package = mkOption {
      type = types.package;
      description = "KDEConnect package to use";
      default = pkgs.libsForQt5.kdeconnect-kde;
      example = "pkgs.libsForQt5.kdeconnect-kde";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    networking.firewall = {
      allowedTCPPortRanges = mkAfter [{
        from = 1714;
        to = 1764;
      }];
      allowedUDPPortRanges = mkAfter [{
        from = 1714;
        to = 1764;
      }];
    };
  };
}
