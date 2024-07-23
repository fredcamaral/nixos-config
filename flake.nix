# flake.nix
{
  description = "Paradise NixOS (fredamaral config)";

  # Define external dependencies and inputs for the flake
  inputs = {
    # Core NixOS packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Hardware-specific configurations
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Default Linux kernel configuration
    systems.url = "github:nix-systems/default-linux";

    # System-wide theming
    stylix.url = "github:danth/stylix";

    # User environment management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Others
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Hypr inputs
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };
  };

  # Define the outputs of the flake
  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixos-hardware,
    systems,
    home-manager,
    stylix,
    hyprland,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (_final: _prev: home-manager.lib);

    # Refer to 'pkgs' for the Nixpkgs Unstable tree
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    # Refer to 'pkgs-stable' for the Nixpkgs Stable tree
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    ## ! Config for your own system
    ## Username
    user = "fredamaral";

    ### Machines names
    desktop = "megaman";
    laptop = "sonic";
    homelab = "zelda";
    raspi = "dk";
    cloudserver = "bomberman";

    ### Other
    domain = "fredamaral.com";
    system = ["x86_64-linux"];
    ## ! ##########################
  in {
    # Use Alejandra as default formatter
    formatter = pkgs.alejandra;

    # DevShell
    perSystem = {
      config,
      pkgs,
      ...
    }: {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.alejandra
          pkgs.git
          pkgs.nodePackages.prettier
          config.packages.repl
        ];
        name = "dots";
        DIRENV_LOG_FORMAT = "";
        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };
    };

    # NixOS configuration for the "megaman" system
    nixosConfigurations = {
      ## ! Config for "megaman" system
      ${desktop} = lib.nixosSystem {
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
  };
}
