{ utils }:

utils.lib.exportModules [
  ./modules/extra-xkb-options.nix

  ./profiles/desktop.nix
  ./profiles/fcitx.nix
  ./profiles/gaming.nix
  ./profiles/gnome.nix
  ./profiles/grub.nix
  ./profiles/ibus.nix
  ./profiles/kde.nix
  ./profiles/shadowsocks.nix
  ./profiles/uefi.nix
  ./profiles/wine.nix
] // {
  hm = utils.lib.exportModules [
    ./modules/hm/vim-plug.nix
  ];
}
