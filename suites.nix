{ utils }:

utils.lib.modulesFromList [
  ./modules/kdeconnect.nix
  ./modules/extra-xkb-options.nix

  ./profiles/desktop.nix
  ./profiles/gnome.nix
  ./profiles/grub.nix
  ./profiles/uefi.nix
] // {
  hm = utils.lib.modulesFromList [ ./modules/hm/vim-plug.nix ];
}
