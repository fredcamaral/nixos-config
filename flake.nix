# flake.nix
{
  description = "Paradise NixOS (fredamaral config)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    systems = {
      url = "github:nix-systems/default-linux";
      # inputs.nixpkgs.follows = "nixpkgs";
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
    # Extend the nixpkgs library with home-manager library
    lib = nixpkgs.lib.extend (_final: _prev: home-manager.lib);

    # Define pkgs for the Nixpkgs Unstable tree
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    # Define pkgs-stable for the Nixpkgs Stable tree
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    # User configuration
    user = "fredamaral";

    # Machine names
    desktop = "megaman";
    laptop = "sonic";
    homelab = "zelda";
    raspi = "dk";
    cloudserver = "bomberman";

    domain = "fredamaral.com";
    system = "x86_64-linux";
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations = {
      # Desktop Configuration
      ${desktop} = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user desktop laptop homelab raspi cloudserver domain;};
        modules = [
          ./system/hosts/${desktop}/configuration.nix
          ./system/common/default.nix
          stylix.nixosModules.stylix
          agenix.nixosModules.default
          {environment.systemPackages = [agenix.packages.${system}.default];}

          # NIX-OS Hardware Specific Configuration
          nixos-hardware.nixosModules.common-gpu-amd

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bkp3";
              extraSpecialArgs = {
                inherit inputs lib desktop laptop homelab raspi cloudserver domain;
              };
              users.${user} = {
                pkgs,
                config,
                ...
              }: {
                imports = [./home];
                _module.args.nixosConfig = config;
                _module.args.hostname = ${desktop};
              };
            };
          }
        ];
      };

      # Mac Intel Configuration
      ${laptop} = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user desktop laptop homelab raspi cloudserver domain;};
        modules = [
          ./system/hosts/${laptop}/configuration.nix
          ./system/common/default.nix
          stylix.nixosModules.stylix
          agenix.nixosModules.default
          {environment.systemPackages = [agenix.packages.${system}.default];}

          # NIX-OS Hardware Specific Configuration
          nixos-hardware.nixosModules.apple-t2

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bkp3";
              extraSpecialArgs = {
                inherit inputs lib desktop laptop homelab raspi cloudserver domain;
              };
              users.${user} = {
                pkgs,
                config,
                ...
              }: {
                imports = [./home];
                _module.args.nixosConfig = config;
                _module.args.hostname = ${laptop};
              };
            };
          }
        ];
      };
    };
  };
}
