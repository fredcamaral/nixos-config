{...}: {
  # Import the modules
  imports =
    map (common: ./${common}.nix) [
      "boot"
      "fonts"
      "internationalisation"
      "nixsettings"
      "packages"
      "programs"
      "security"
      "stylix"
      "time"
      "users"
    ]
    ++ [
      # Secrets Setup
      # ./secrets
    ];
}
