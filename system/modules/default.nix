{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "boot"
      "fonts"
      "hardware"
      "internationalisation"
      "console"
      "nixsettings"
      "packages"
      "programs"
      "security"
      "services"
      "stylix"
      "time"
      "users"
      "virtualisation"
      "zfs"
    ]
    ++ [
      # Graphical environment
      ./graphical
      # Networking and VPN
      ./networking
      # Secrets Setup
      ./secrets
    ];
}
