# Lymypyry

Flake with my NixOS configuration, used packages and modules.

## Outputs

### Packages

`electron-mksnapshot` - Electron `mksnpashot` utility.

`epson_201401w` — driver for EPSON printers (series L456, L455, L366, L365, 
L362, L360, L312, L310, L222, L220, L132, L130).

`hfst` — [Helsinki Finite-State Technology](https://hfst.github.io) tools and
libraries.

`hyperCanary` - Canary build of [Hyper](https://hyper.is) terminal.

`memento` — [An mpv-based video player for studying Japanese](https://github.com/ripose-jp/Memento).

`pascalabcnet` — [PascalABC.NET compiler](http://pascalabc.net/en/).

### Modules

`extra-xkb-options` — allow to add custom XKB options (as symbols).

This effectively creates an overlay with modified `xorg` which requires
rebuilding a ton of derivations (including `webkitgtk` in some configurations).
Use with caution!

```nix
{
  services.xserver.extraXkbOptions = {
    "<file>"."<name>" = {
      # expose the option by followign name (default: <file>:<name>)
      bindAs = "my:option";
      # symbols to include (optional)
      include = [ "latin" ];
      # layouts to expose option to (optional, if more than one)
      layouts = [ "us" ];

      # key definitions
      keys."<key>" = [ "NoSymbol" "NoSymbol" "adiaeresis" "Adiaeresis" ];
    };
  };
}
```
