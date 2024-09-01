# home/default.nix
{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  lib,
  nixosConfig,
  user,
  hostname,
  ...
}: {
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = ["$HOME/.local/bin"];

    preferXdgDirectories = true;
    activation = {
      createScreenshotsDir = config.lib.dag.entryAfter ["writeBoundary"] ''
        mkdir -p "${config.xdg.userDirs.pictures}/screenshots"
      '';
      linkHomeManagerConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir -p ~/.config/home-manager
        ln -sfn ~/repos/nixos-config/home/${hostname}.nix ~/.config/home-manager/home.nix
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
  imports = [
    ./common/xdg.nix
    ./common/programs.nix
    ./common/aliases.nix
    ./common/direnv.nix
    ./common/stylix.nix
    ./sway
    # ./hyprland
  ];

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Set the state version for Home Manager
  home.stateVersion = "24.05";
}
