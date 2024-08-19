{
  description = "Paradise NixOS (fredamaral config)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    agenix,
    stylix,
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

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    mkSystem = hostname: system: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs hostname user domain system;} // machines;
        modules =
          [
            stylix.nixosModules.stylix
            agenix.nixosModules.default
            ./system/hosts/${hostname}/configuration.nix
            ./system/common/default.nix
            {nixpkgs.config.allowUnfree = true;}
          ]
          ++ extraModules;
      };

    mkHome = hostname: system:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inherit inputs hostname user;} // machines;
        modules = [
          stylix.homeManagerModules.stylix
          agenix.homeManagerModules.default
          ./home/${hostname}.nix
          {nixpkgs.config.allowUnfree = true;}
        ];
      };
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations = {
      ${machines.desktop} = mkSystem machines.desktop "x86_64-linux" [];
      ${machines.laptop-nixos} = mkSystem machines.laptop-nixos "aarch64-linux" [];
      ${machines.laptop-macos} = mkSystem machines.laptop-macos "aarch64-linux" [];
    };

    homeConfigurations = {
      "${user}@${machines.desktop}" = mkHome machines.desktop "x86_64-linux";
      "${user}@${machines.laptop-nixos}" = mkHome machines.laptop-nixos "aarch64-linux";
      "${user}@${machines.laptop-macos}" = mkHome machines.laptop-macos "aarch64-linux";
    };
  };
}
