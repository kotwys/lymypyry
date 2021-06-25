# Lymypyry

Flake with my NixOS configuration, used packages and modules.

## Outputs

### Packages

`epson_201401w` — driver for EPSON printers (series L456, L455, L366, L365, 
L362, L360, L312, L310, L222, L220, L132, L130).

`gnome-shell-extension-dash-to-dock` — Dash to Dock extension as at 
[ewlsh/gnome-40][ewlsh/gnome-40] branch.

`tl-minecraft` — Minecraft launcher.

### Modules

`kdeconnect` — adds the KDEConnect service with an appropriate firewall 
configuration.

```nix
services.kdeconnect = {
  enable = true;
  package = pkgs.kdeconnect; # also works with gsconnect
};
```

[ewlsh/gnome-40]: https://github.com/ewlsh/dash-to-dock/tree/ewlsh/gnome-40
