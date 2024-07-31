{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      # "monitoring"
      "netdata"
      "services"
      "virtualisation"
      "packages"
      "power-management"
      "zfs"
    ]
    ++ [
      # Networking and VPN
      ./networking
    ];
}
