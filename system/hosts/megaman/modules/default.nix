{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      "monitoring"
      "services"
      "zfs"
    ]
    ++ [
      # Networking and VPN
      ./networking
    ];
}
