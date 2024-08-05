{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      # "monitoring"
      # "netdata"
      "nixsettings"
      "services"
      "virtualisation"
      "packages"
      "power-management"
      "programs"
      "zfs"
    ]
    ++ [
      # Networking and VPN
      ./networking
    ];
}
