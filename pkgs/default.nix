{ pkgs }:

let
  callPackage = pkgs.lib.callPackageWith (pkgs // packages);
  packages = {
    epson_201401w = callPackage ./misc/drivers/epson_201401w { };
    hfst = callPackage ./development/libraries/hfst { };
    memento = pkgs.libsForQt5.callPackage ./applications/video/memento.nix { };
    pascalabcnet = callPackage ./development/compilers/pascalabcnet { };
    electron-mksnapshot = callPackage ./development/tools/electron/mksnapshot { } "25.3.1" {
      x86_64-linux = "9df13445da3eebe19eab4310669a7271ba4643542aa792dffbb25ecca0205c16";
    };
    hyperCanary = callPackage ./applications/terminal-emulators/hyper {
      version = "4.0.0-canary.5";
      sha256 = "0q2ylm17jlgm383a4ccqx0nzdspq34xqk8vp3mlhki6bl51ar481";
    };
  };
in
packages
