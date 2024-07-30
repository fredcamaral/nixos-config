{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      "monitoring"
      "services"
      "virtualisation"
      "power-management"
      "zfs"
    ]
    ++ [
      # Networking and VPN
      ./networking
    ];
}
