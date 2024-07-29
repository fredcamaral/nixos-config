{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "boot"
      # "btrfs-snapshots"
      "fonts"
      "hardware"
      "internationalisation"
      "console"
      # "monitoring"
      "nixsettings"
      "packages"
      "power-management"
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
      #./secrets
    ];
}
