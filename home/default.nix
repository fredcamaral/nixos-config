# home/default.nix
{
  config,
  pkgs,
  lib,
  nixosConfig,
  ...
}: let
  user = "fredamaral";

  # Define the path to your Hyprland configuration
  hyprlandConfigPath = ./graphical/hyprland;
  # Define the path to your Sway configuration
  swayConfigPath = ./graphical/sway;
in {
  # Set up the home directory and environment variables
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

    # Custom scripts
    file.".local/bin/focus-mode.sh" = {
      text = ''
        #!${pkgs.bash}/bin/bash

          FOCUS_MODE_FILE="/tmp/sway_focus_mode"

          toggle_focus_mode() {
              if [ -f "$FOCUS_MODE_FILE" ]; then
                  rm "$FOCUS_MODE_FILE"
                  swaymsg "for_window [app_id=.*] opacity 1"
                  notify-send "Focus Mode Disabled" "Normal window opacity restored"
              else
                  touch "$FOCUS_MODE_FILE"
                  swaymsg "for_window [app_id=.*] opacity 0.8"
                  swaymsg "[con_id=$(swaymsg -t get_tree | jq '.. | select(.focused? == true) | .id')] opacity 1"
                  notify-send "Focus Mode Enabled" "Other windows dimmed"
              fi
          }

          update_focus() {
              if [ -f "$FOCUS_MODE_FILE" ]; then
                  swaymsg "for_window [app_id=.*] opacity 0.8"
                  swaymsg "[con_id=$(swaymsg -t get_tree | jq '.. | select(.focused? == true) | .id')] opacity 1"
              fi
          }

          case "$1" in
              toggle)
                  toggle_focus_mode
                  ;;
              update)
                  update_focus
                  ;;
              *)
                  echo "Usage: $0 {toggle|update}"
                  exit 1
                  ;;
          esac
      '';
      executable = true;
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
      ./dotfiles.nix
      ./stylix.nix
    ]
    ++ lib.optional nixosConfig.graphical.managers.hyprland.enable hyprlandConfigPath
    ++ lib.optional nixosConfig.graphical.managers.sway.enable swayConfigPath;

  # Garbage Collection
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable numlock on session start
  xsession.numlock.enable = true;

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Set the state version for Home Manager
  home.stateVersion = "24.05";
}
