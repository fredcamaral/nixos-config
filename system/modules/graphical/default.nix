{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./graphical-module.nix
  ];

  # Graphical environment configuration
  graphical = {
    xdefaults.enable = true; # Enable X-Server defaults (true by default)
    managers = {
      enable = true; # Enable graphical environment (false by default)

      # Choose one of the following (or none for default GNOME):
      gnome.enable = true;
      # hyprland.enable = true;
      # sway.enable = true;
      # i3.enable = true;
    };
  };
}
