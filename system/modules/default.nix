{...}: {
  imports = map (module: ./${module}.nix) [
    "boot"
    "fonts"
    "hardware"
    "internationalisation"
    "console"
    "networking"
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

    # WM
    "gnome"
  ];
}
