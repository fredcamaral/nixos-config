# flake.nix
{
  description = "Megadrive NixOS";

  # Define external dependencies and inputs for the flake
  inputs = {
    # Core NixOS packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Hardware-specific configurations
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # System-wide theming
    stylix.url = "github:danth/stylix";

    # User environment management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Define the outputs of the flake
  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    stylix,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (_final: _prev: home-manager.lib);
    user = "fredamaral";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    formatter = pkgs.alejandra;

    # NixOS configuration for the "megaman" system
    nixosConfigurations.megaman = lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs user;};
      modules = [
        ./system/configuration.nix
        nixos-hardware.nixosModules.common-gpu-amd
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bkp";
            extraSpecialArgs = {inherit inputs;};
            users.${user} = import ./home;
          };
        }
      ];
    };
  };
}
