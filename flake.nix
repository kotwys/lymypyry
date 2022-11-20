{
  description = "My NixOS config, modules and packages.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.3.1";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, home-manager, helix, ... }@inputs:
    let suites = import ./suites.nix { inherit utils; };
    in utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;
      channels.nixpkgs = {
        input = nixpkgs;
        overlaysBuilder = _: [
          (_: _: { locals = self.packages.x86_64-linux; })
          (_: _: { helix = helix.packages.x86_64-linux.helix; })
        ];
      };

      hostDefaults.modules = [
        nixpkgs.nixosModules.notDetected
        home-manager.nixosModules.home-manager
        ({ pkgs, ... }: {
          nix = {
            package = pkgs.nixFlakes;
            generateRegistryFromInputs = true;
            generateNixPathFromInputs = true;
          };
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = builtins.attrValues suites.hm;
          };
        })
      ] ++ (builtins.attrValues self.nixosModules);

      hosts.kotwys-pc.modules =
        [ ./hosts/kotwys-pc.nix ]
        ++ (builtins.attrValues {
          inherit (suites) uefi desktop gaming gnome;
        });

      hosts.kotwys-lap.modules =
        [ ./hosts/kotwys-lap.nix ]
        ++ (builtins.attrValues {
          inherit (suites) grub desktop gnome;
        });

      hosts.valo.modules =
        [ ./hosts/valo.nix ]
        ++ (builtins.attrValues {
          inherit (suites) uefi desktop gnome;
        });

      outputsBuilder = channels: {
        packages = import ./pkgs {
          pkgs = channels.nixpkgs;
        };
      };
      nixosModules = { inherit (suites) kdeconnect extra-xkb-options; };
    };
}
