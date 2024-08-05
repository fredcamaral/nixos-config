{...}: {
  # Import the modules
  imports = map (module: ./${module}.nix) [
    "hardware"
    "services"
    "virtualisation"
    "packages"
    "power-management"
    "programs"
  ];
}
