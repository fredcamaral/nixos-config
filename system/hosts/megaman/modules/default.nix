{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      "monitoring"
      "services"
      "virtualisation"
      "zfs"
    ]
    ++ [
      # Networking and VPN
      ./networking
    ];
}
