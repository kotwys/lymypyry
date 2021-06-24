{ pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    cheese
    epiphany
    totem
    geary
    seahorse
  ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.gnome-shell-extension-tray-icons-reloaded
    gnomeExtensions.gnome-shell-extension-blur-my-shell
    locals.gnome-shell-extension-dash-to-dock
  ];

  services.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
}
