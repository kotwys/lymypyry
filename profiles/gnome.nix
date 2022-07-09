{ pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = [
    pkgs.epiphany
    pkgs.gnome.cheese
    pkgs.gnome.geary
    pkgs.gnome.seahorse
    pkgs.gnome.totem
  ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
  ];

  services.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
}
