{ pkgs, ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.steam-hardware.enable = true; # Flatpak steam won't run

  services.zerotierone.enable = true;
  networking.firewall.trustedInterfaces = [ "zt+" ];
}
