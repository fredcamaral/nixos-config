{
  description = "Paradise NixOS (fredamaral config)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    systems.url = "github:nix-systems/default-linux";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixos-hardware,
    systems,
    home-manager,
    agenix,
    stylix,
    hyprland,
    ...
  } @ inputs: let
    user = "fredamaral";
    system = "x86_64-linux";
    machines = {
      desktop = "megaman";
      laptop = "sonic";
      homelab = "zelda";
      raspi = "dk";
      cloudserver = "bomberman";
    };
    domain = "fredamaral.com";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    mkSystem = hostname: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user hostname domain;} // machines;
        modules =
          [
            ./system/hosts/${hostname}/configuration.nix
            ./system/common/default.nix
            stylix.nixosModules.stylix
            agenix.nixosModules.default
            nix-index-database.nixosModules.nix-index
            {programs.nix-index-database.comma.enable = true;}
            home-manager.nixosModules.home-manager
            {
              environment.systemPackages = [agenix.packages.${system}.default];
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "bkp3";
                extraSpecialArgs = {inherit inputs;} // machines;
                users.${user} = {
                  pkgs,
                  config,
                  ...
                }: {
                  imports = [./home];
                  _module.args.nixosConfig = config;
                  _module.args.hostname = hostname;
                };
              };
            }
          ]
          ++ extraModules;
      };
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations = {
      ${machines.desktop} = mkSystem machines.desktop [nixos-hardware.nixosModules.common-gpu-amd];
      ${machines.laptop} = mkSystem machines.laptop [nixos-hardware.nixosModules.apple-t2];
    };
  };
}
