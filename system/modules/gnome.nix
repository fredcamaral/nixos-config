# system/modules/services.nix
{pkgs, ...}: {
  services = {
    gnome = {
      # Enable GNOME Keyring
      gnome-keyring.enable = true;

      # Enable GNOME's quick file previewer
      sushi.enable = true;
    };

    # Configure X11 display server
    xserver = {
      enable = true;
      xkb.layout = "us";
      # xkb.variant = "intl";

      # Enable GNOME desktop environment
      desktopManager.gnome.enable = true;

      # Use GDM as display manager
      displayManager.gdm.enable = true;
    };
  };

  environment.systemPackages = with pkgs;
    [
      # GNOME Specific
      gnome-tweaks # Graphical interface for advanced GNOME 3 settings
    ]
    ++ (with pkgs.gnomeExtensions; [
      space-bar
      gtile
      focus-changer
      appindicator
      dim-background-windows
      day-progress
      astra-monitor
      smart-auto-move
    ]);

  # Excluded GNOME packages
  environment.gnome.excludePackages = with pkgs;
    [
      cheese # GNOME webcam application
      epiphany # GNOME web browser
      geary # GNOME email client
      gedit # GNOME text editor
      gnome-photos # Photo manager for GNOME
      gnome-tour # GNOME's new user tour application
      yelp # GNOME help viewer
      xterm # Terminal emulator for the X Window System
    ]
    ++ (with pkgs.gnome; [
      atomix # GNOME puzzle game
      gnome-calendar # GNOME calendar application
      gnome-characters # GNOME utility for finding and inserting unusual characters
      gnome-contacts # GNOME contacts manager
      gnome-initial-setup # GNOME initial setup wizard
      gnome-maps # GNOME maps application
      gnome-music # GNOME music player
      hitori # GNOME sudoku game
      iagno # GNOME reversi game
      tali # GNOME poker game
    ]);
}
