{ pkgs }:

{
  epson_201401w = pkgs.callPackage ./misc/drivers/epson_201401w { };
  memento = pkgs.libsForQt5.callPackage ./applications/video/memento.nix { };
  pascalabcnet = pkgs.callPackage ./development/compilers/pascalabcnet { };
}
