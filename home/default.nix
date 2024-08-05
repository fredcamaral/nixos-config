# home/default.nix
{
  config,
  pkgs,
  lib,
  nixosConfig,
  user,
  ...
}: let
  hyprlandConfigPath = ./graphical/hyprland;
  swayConfigPath = ./graphical/sway;
  lightSwayConfigPath = ./graphical/lightSway;
in {
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = ["$HOME/.local/bin"];

    preferXdgDirectories = true;
    activation = {
      createScreenshotsDir = config.lib.dag.entryAfter ["writeBoundary"] ''
        mkdir -p "${config.xdg.userDirs.pictures}/screenshots"
      '';
    };

    # Set session variables
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "micro";
      TERMINAL = "kitty";
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
  };

  # Settings Icons
  gtk = {
    enable = true;
    iconTheme.name = "Vimix-White";
    iconTheme.package = pkgs.vimix-icon-theme;
  };

  # Import additional configuration files
  imports =
    [
      ./xdg.nix
      ./programs.nix
      ./aliases.nix
      ./direnv.nix
      ./stylix.nix
    ]
    ++ lib.optional nixosConfig.graphical.managers.hyprland.enable hyprlandConfigPath
    ++ lib.optional nixosConfig.graphical.managers.sway.enable swayConfigPath
    ++ lib.optional nixosConfig.graphical.managers.lightSway.enable lightSwayConfigPath;

  # Garbage Collection
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Set the state version for Home Manager
  home.stateVersion = "24.05";
}
