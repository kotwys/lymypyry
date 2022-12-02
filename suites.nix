{ utils }:

utils.lib.exportModules [
  ./modules/kdeconnect.nix
  ./modules/extra-xkb-options.nix

  ./profiles/desktop.nix
  ./profiles/gaming.nix
  ./profiles/gnome.nix
  ./profiles/grub.nix
  ./profiles/uefi.nix
  ./profiles/wine.nix
] // {
  hm = utils.lib.exportModules [
    ./modules/hm/vim-plug.nix
  ];
}
