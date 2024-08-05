{...}: {
  # Import the modules
  imports = map (module: ./${module}.nix) [
    "console"
    "hardware"
    "services"
    "virtualisation"
    "packages"
    "xserver"
  ];
}
