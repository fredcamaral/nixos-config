{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      "services"
      "packages"
    ]
    ++ [
      # Graphical environment
      ./graphical
    ];
}
