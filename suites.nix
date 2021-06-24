{ utils }:

utils.lib.modulesFromList [
  ./modules/kdeconnect.nix

  ./profiles/desktop.nix
  ./profiles/gnome.nix
  ./profiles/uefi.nix
] // {
  hm = utils.lib.modulesFromList [ ./modules/hm/vim-plug.nix ];
}
