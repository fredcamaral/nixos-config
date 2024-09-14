{
  hostname,
  lib,
  ...
}: {
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
      # ./gnome
      # ./xfce
      ./i3
      # ./sway
      # ./hyprland
    ];
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
