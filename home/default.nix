# home/default.nix
{pkgs, ...}: let
  user = "fredamaral";
in {
  # Set up the home directory and environment variables
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    # Set session variables
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "micro";
      TERMINAL = "kitty";
    };

    file.".local/bin/init-gnome-default-apps.sh" = {
      text = ''
        #!/bin/sh
        ${pkgs.firefox}/bin/firefox -P "space-main" -no-remote &
        ${pkgs.firefox}/bin/firefox -P "space-dev" -no-remote &
        ${pkgs.firefox}/bin/firefox -P "space-qbit" -no-remote &
        ${pkgs.firefox}/bin/firefox -P "space-qbit" -no-remote &
        ${pkgs.kitty}/bin/kitty --class "space-main" &
        ${pkgs.kitty}/bin/kitty --class "aux-1" &
        ${pkgs.kitty}/bin/kitty --class "btop" btop &
        ${pkgs.code}/bin/code --class "vscode" &
        ${pkgs.qbittorrent}/bin/qbittorrent --class "qbit" &
        ${pkgs.vscode}/bin/code --class "vscode" &
        ${pkgs.obsidian}/bin/obsidian --class "obsidian" &
      '';
      executable = true;
    };
  };

  # Import additional configuration files
  imports = [
    ./xdg.nix
    ./programs.nix
    ./aliases.nix
    ./direnv.nix
  ];

  # Enable numlock on session start
  xsession.numlock.enable = true;

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Set the state version for Home Manager
  home.stateVersion = "24.05";
}
