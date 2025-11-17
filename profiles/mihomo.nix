{ pkgs, ... }:

{
  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = "/etc/mihomo.yml";
  };
  networking.firewall = {
    trustedInterfaces = [ "utun0" ];
    checkReversePath = false;
  };
}
