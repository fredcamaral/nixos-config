{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
  };

  environment.sessionVariables = {
    "XDG_CURRENT_DESKTOP" = "XFCE";
    "XDG_SESSION_TYPE" = "x11";
    "QT_QPA_PLATFORMTHEME" = "qt5ct";
  };

  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-screenshooter
    xfce.xfce4-taskmanager
    xfce.xfce4-terminal
    xfce.xfce4-settings
    xfce.xfconf
    xfce.thunar
    libnotify
    qt5ct
    gtk3
    glib
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];

  # Enable some XFCE-related services
  services.upower.enable = true;
  services.accounts-daemon.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
