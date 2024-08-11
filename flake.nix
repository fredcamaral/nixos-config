{
  description = "Paradise NixOS (fredamaral config)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
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
    home-manager,
    agenix,
    stylix,
    hyprland,
    ...
  } @ inputs: let
    user = "fredamaral";
    system = ["x86_64-linux" "aarch64-linux"];
    machines = {
      desktop = "megaman";
      laptop-nixos = "bomberman";
      laptop-macos = "sonic";
      homelab = "zelda";
    };
    domain = "fredamaral.com";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    mkSystem = hostname: system: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user hostname domain system;} // machines;
        modules =
          [
            ./system/hosts/${hostname}/configuration.nix
            ./system/common/default.nix
            stylix.nixosModules.stylix
            agenix.nixosModules.default
          ]
          ++ (
            if hostname == machines.desktop
            then [
              home-manager.nixosModules.home-manager
              {
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
                    _module.args.user = user;
                  };
                };
              }
            ]
            else []
          )
          ++ extraModules;
      };
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations = {
      ${machines.desktop} = mkSystem machines.desktop "x86_64-linux" [];
      ${machines.laptop-nixos} = mkSystem machines.laptop-nixos "aarch64-linux" [];
      ${machines.laptop-macos} = mkSystem machines.laptop-macos "aarch64-linux" [];
    };
  };
}
