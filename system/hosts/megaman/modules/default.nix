{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      "monitoring"
      "security"
      "services"
      "zfs"
    ]
    ++ [
      # Graphical environment
      ./graphical
      # Networking and VPN
      ./networking
      # Secrets Setup
      #./secrets
    ];
}
