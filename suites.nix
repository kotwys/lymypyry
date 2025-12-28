{ utils }:

utils.lib.exportModules [
  ./modules/extra-xkb-options.nix

  ./profiles/bluetooth.nix
  ./profiles/desktop.nix
  ./profiles/fcitx.nix
  ./profiles/gaming.nix
  ./profiles/gnome.nix
  ./profiles/grub.nix
  ./profiles/ibus.nix
  ./profiles/kde.nix
  ./profiles/mihomo.nix
  ./profiles/uefi.nix
  ./profiles/v2ray.nix
  ./profiles/virtmanager.nix
  ./profiles/virtualbox.nix
  ./profiles/wine.nix
  ./profiles/zapret.nix
] // {
  hm = utils.lib.exportModules [
    ./modules/hm/vim-plug.nix
  ];
}
