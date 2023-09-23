{ pkgs, lib, config, ... }:

{
  services.httpd = {
    enable = true;
    enablePHP = true;
    virtualHosts.localhost = {
      documentRoot = "/var/www";
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 ];
  };

  system.stateVersion = lib.mkDefault "23.05";
  environment.etc."resolv.conf" = lib.mkIf config.boot.isContainer {
    text = lib.mkDefault "nameserver 8.8.8.8";
  };
}
