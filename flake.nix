{
  description = "Aori's Stateless NixOS Flake";

  # Inputs
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };
    lazyvim.url = "github:pfassina/lazyvim-nix";
  };

  outputs = { self, nixpkgs, home-manager, impermanence, niri, noctalia, lazyvim, ... }@inputs: {
    nixosConfigurations.Phantom = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./configuration.nix
        home-manager.nixosModules.home-manager
        niri.nixosModules.niri
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.aori = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    };
  };
}

