{ pkgs }:

{
  epson_201401w = pkgs.callPackage ./misc/drivers/epson_201401w { };
  tl-minecraft = pkgs.callPackage ./games/tl-minecraft { };
  memento = pkgs.libsForQt5.callPackage ./applications/video/memento.nix { };
}
