{ pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true; # Flatpak steam won't run
  environment.systemPackages = [
    pkgs.wineWowPackages.stable
  ];

  services.zerotierone.enable = true;
  networking.firewall.trustedInterfaces = [ "zt+" ];
  programs.adb.enable = true;
}
