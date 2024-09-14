{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
    };
  };

  environment.sessionVariables = {
    # "XDG_CURRENT_DESKTOP" = "XFCE";
    # "XDG_SESSION_TYPE" = "x11";
    # "QT_QPA_PLATFORMTHEME" = "qt5ct";
  };

  environment.systemPackages = with pkgs; [
    xfce.thunar
    libnotify
    qt5ct
    gtk3
    gtk4
    glib
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];

  # Enable some XFCE-related services
  services.upower.enable = true; # Power management
  services.accounts-daemon.enable = true; # User accounts
  services.gvfs.enable = true; # File sharing
  services.tumbler.enable = true; # Screenshots
}
