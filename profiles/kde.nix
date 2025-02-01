{ pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      libreoffice-qt6-fresh vanilla-dmz xdg-desktop-portal-gtk
      kwin-effects-forceblur;
    inherit (pkgs.kdePackages) skanpage;
  };
}
