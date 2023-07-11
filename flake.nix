{
  description = "My NixOS config, modules and packages.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.3.1";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    # Pinpoint an older version of Hyper:
    # https://github.com/NixOS/nixpkgs/issues/105961
    hyperpkgs.url = "github:NixOS/nixpkgs/60c0f7626589";
  };

  outputs =
    { self, nixpkgs, utils, home-manager, emacs-overlay
    , hyperpkgs, ... }@inputs:
    let
      suites = import ./suites.nix { inherit utils; };
      hyper = (import hyperpkgs { system = "x86_64-linux"; }).hyper;
    in utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;
      channels.nixpkgs = {
        input = nixpkgs;
        overlaysBuilder = _: [
          (_: _: { inherit hyper; })
          (_: _: { locals = self.packages.x86_64-linux; })
          emacs-overlay.overlay
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
        ./cachix.nix
      ] ++ (builtins.attrValues self.nixosModules);

      hosts.kotwys-pc.modules =
        [ ./hosts/kotwys-pc.nix ]
        ++ (builtins.attrValues {
          inherit (suites) uefi desktop gaming gnome wine;
        });

      hosts.kotwys-lap.modules =
        [ ./hosts/kotwys-lap.nix ]
        ++ (builtins.attrValues {
          inherit (suites) grub desktop gnome;
        });

      hosts.valo.modules =
        [ ./hosts/valo.nix ]
        ++ (builtins.attrValues {
          inherit (suites) uefi desktop gnome wine;
        });

      outputsBuilder = channels: {
        packages = import ./pkgs {
          pkgs = channels.nixpkgs;
        };
      };
      nixosModules = { inherit (suites) kdeconnect extra-xkb-options; };
    };
}
