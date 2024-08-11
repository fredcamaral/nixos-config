{...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
      # "monitoring"
      # "netdata"
      "console"
      "nixsettings"
      "services"
      "virtualisation"
      "packages"
      "power-management"
      "programs"
      "zfs"
    ]
    ++ [
      ./sway
    ];
  networking.hostName = "megaman";
}
