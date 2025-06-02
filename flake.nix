{
  description = "My NixOS config, modules and packages.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.5.1";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, home-manager, ... }@inputs:
    let
      suites = import ./suites.nix { inherit utils; };
    in utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;
      channels.nixpkgs = {
        input = nixpkgs;
        overlaysBuilder = _: [
          (_: _: { locals = self.packages.x86_64-linux; })
          (_: _: {
            kwin-effects-forceblur =
              inputs.kwin-effects-forceblur.packages.x86_64-linux.default;
          })
        ];
      };

      hostDefaults.modules = [
        nixpkgs.nixosModules.notDetected
        home-manager.nixosModules.home-manager
        ({ pkgs, ... }: {
          nix.package = pkgs.lix;
          nix.generateRegistryFromInputs = true;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = builtins.attrValues suites.hm;
          };
        })
        ./cachix.nix
      ] ++ (builtins.attrValues self.nixosModules);

      hosts.kotwys-pc.modules =
        [ ./hosts/kotwys-pc.nix ]
        ++ (builtins.attrValues {
          inherit (suites) uefi desktop gaming kde wine fcitx v2ray virtualbox;
        });

      hosts.kotwys-lap.modules =
        [ ./hosts/kotwys-lap.nix ]
        ++ (builtins.attrValues {
          inherit (suites) grub desktop gnome;
        });

      hosts.valo.modules =
        [ ./hosts/valo.nix ]
        ++ (builtins.attrValues {
          inherit (suites) uefi desktop kde wine fcitx v2ray virtualbox;
        });

      outputsBuilder = channels: {
        packages = import ./pkgs {
          pkgs = channels.nixpkgs;
        };
      };
      nixosModules = { inherit (suites) extra-xkb-options; };
    };
}
