{...}: {
  # Import the modules
  imports = map (files: ./${files}.nix) [
    "routing"
    "networking"
  ];
}
