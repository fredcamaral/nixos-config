{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      "services"
    ]
    ++ [
      # Graphical environment
      ./graphical
    ];
}
