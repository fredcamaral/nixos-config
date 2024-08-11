{hostname, ...}: {
  # Import the modules
  imports =
    map (module: ./${module}.nix) [
      "hardware"
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
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    useDHCP = true;
  };
}
