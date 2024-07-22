# home/default.nix
{pkgs, ...}: let
  user = "fredamaral";
in {
  # Set up the home directory and environment variables
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = ["$HOME/.local/bin"];
    preferXdgDirectories = true;

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
        ${pkgs.firefox}/bin/firefox -P "space-notes" -no-remote &
        ${pkgs.kitty}/bin/kitty --class "space-main" &
        ${pkgs.kitty}/bin/kitty --class "aux-1" &
        ${pkgs.kitty}/bin/kitty --class "btop" btop &
        ${pkgs.vscode}/bin/code --class "vscode" &
        ${pkgs.qbittorrent}/bin/qbittorrent &
        ${pkgs.obsidian}/bin/obsidian --class "obsidian" &
        ${pkgs.dopamine}/bin/dopamine --class "dopamine" &
        ${pkgs.telegram-desktop}/bin/telegram-desktop --class "telegram" &
        ${pkgs.whatsapp-for-linux}/bin/whatsapp-for-linux --class "whatsapp" &
        ${pkgs.slack}/bin/slack --class "slack" &
      '';
      executable = true;
    };

    file.".local/bin/wayland-sessions.sh" = {
      text = ''
        #!/bin/sh
        gdbus call --session \
        --dest org.gnome.Shell \
        --object-path /org/gnome/Shell \
        --method org.gnome.Shell.Eval \
        "const windows = global.get_window_actors().map(w => w.meta_window);
         windows.forEach(w => {
           print('Title: ' + w.get_title());
           print('App ID: ' + (w.get_gtk_application_id() || 'N/A'));
           print('WM Class: ' + w.get_wm_class());
           print('Process ID: ' + w.get_pid());
           print('---');
         });"
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
