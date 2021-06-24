{
  description = "My NixOS config, modules and packages.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, home-manager, ... }@inputs:
    let suites = import ./suites.nix { inherit utils; };
    in utils.lib.systemFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;
      channels.nixpkgs = {
        input = nixpkgs;
        overlaysBuilder = _:
          [ (_: _: { locals = self.packages.x86_64-linux; }) ];
      };

      hostDefaults.modules = [
        nixpkgs.nixosModules.notDetected
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = builtins.attrValues suites.hm;
          };
        }
        utils.nixosModules.saneFlakeDefaults
      ] ++ (builtins.attrValues self.nixosModules);

      hosts.kotwys-pc.modules = with suites; [
        ./hosts/kotwys-pc.nix
        uefi
        desktop
        gnome
      ];

      # Flake outputs

      nixosModules = { inherit (suites) kdeconnect; };

      packagesBuilder = { nixpkgs }: import ./pkgs { pkgs = nixpkgs; };
    };
}
