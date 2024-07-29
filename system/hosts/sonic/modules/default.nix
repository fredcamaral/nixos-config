{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      "services"
      "packages"
    ]
    ++ [
      # Networking and VPN
      ./networking
    ];
}
