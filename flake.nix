{
  # Description
  description = "Aori's Stateless NixOS Flake";

  # Inputs
  inputs = {
    # Nix Default Package Repo
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Caelestia Shell
    caelestia-shell.url = "github:caelestia-dots/shell";
  };

  # Outputs
  outputs = { self, nixpkgs, home-manager, caelestia-shell, ... }@inputs: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      # Modules
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          # Home-Manager
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.aori = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs caelestia-shell; };
          };
        }
      ];
    };
  };
}
