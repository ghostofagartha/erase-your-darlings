{
  # Description
  description = "Aori's Stateless NixOS Flake";

  # Inputs
  inputs = {
    # Nix Default Package Repo
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Stable nixpkgs
    stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";
  };

  # Outputs
  outputs =
    { self
    , nixpkgs
    , stable
    , home-manager
    , impermanence
    , ...
    }@inputs:

    let
      system = "x86_64-linux";

      # Stable package set
      stablePkgs = import stable {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations.nixos-btw =
        nixpkgs.lib.nixosSystem {
          inherit system;

          # Pass variables to all modules
          specialArgs = {
            inherit inputs stablePkgs;
          };

          # Modules
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
	    impermanence.nixosModules.impermanence
            {
              # Home-Manager
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.aori = import ./home.nix;

                backupFileExtension = "backup";

                # Pass variables to home-manager modules
                extraSpecialArgs = {
                  inherit
                    inputs
                    stablePkgs;
                };
              };
            }
          ];
        };
    };
}
