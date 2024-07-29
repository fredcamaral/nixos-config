{...}: {
  # Import the modules
  imports = map (module: ./${module}.nix) [
    "boot"
    "fonts"
    "internationalisation"
    "console"
    "nixsettings"
    "packages"
    "power-management"
    "programs"
    "security"
    "stylix"
    "time"
    "users"
    "virtualisation"
  ];
}
