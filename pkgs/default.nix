{ pkgs }:

{
  epson_201401w = pkgs.callPackage ./misc/drivers/epson_201401w { };
  tl-minecraft = pkgs.callPackage ./games/tl-minecraft { };
  gnome-shell-extension-dash-to-dock =
    pkgs.callPackage ./desktops/gnome/extensions/dash-to-dock { };
}
