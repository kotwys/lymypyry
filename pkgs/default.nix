{ pkgs }:

let
  callPackage = pkgs.lib.callPackageWith (pkgs // packages);
  packages = {
    epson_201401w = callPackage ./misc/drivers/epson_201401w { };
    memento = pkgs.libsForQt5.callPackage ./applications/video/memento.nix { };
    pascalabcnet = callPackage ./development/compilers/pascalabcnet { };
    electron-mksnapshot = callPackage ./development/tools/electron/mksnapshot { } "25.1.1" {
      x86_64-linux = "1xwkqzjxvqq7l7wghrh30xsbs71ywmzszjp64kr6i1xkp44zwsii";
    };
    hyperCanary = callPackage ./applications/terminal-emulators/hyper {
      version = "4.0.0-canary.5";
      sha256 = "0q2ylm17jlgm383a4ccqx0nzdspq34xqk8vp3mlhki6bl51ar481";
    };
  };
in
packages
