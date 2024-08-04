{...}: {
  # Import the modules
  imports =
    map (common: ./${common}.nix) [
      "boot"
      "fonts"
      "internationalisation"
      "console"
      "nixsettings"
      "packages"
      "programs"
      "security"
      "stylix"
      "time"
      "users"
    ]
    ++ [
      # Graphical environment
      ./graphical
      # Secrets Setup
      ./secrets
    ];
}
