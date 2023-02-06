{ pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true; # Flatpak steam won't run

  services.zerotierone.enable = true;
  networking.firewall.trustedInterfaces = [ "zt+" ];
}
