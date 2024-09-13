{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.sessionVariables = {
    "XDG_CURRENT_DESKTOP" = "gnome";
    "XDG_SESSION_TYPE" = "wayland";
    "QT_QPA_PLATFORM" = "wayland";
    "GDK_BACKEND" = "wayland";
    "MOZ_ENABLE_WAYLAND" = "1";
    "CLUTTER_BACKEND" = "wayland";
  };

  services.gnome = {
    core-utilities.enable = true;
    gnome-keyring.enable = true;
  };

  programs.gnome-terminal.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    libnotify
    polkit_gnome
    qt5.qtwayland
    qt6.qtwayland
    gtk3
    gtk4
    glib
    gsettings-desktop-schemas
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gnome
  ];

  # Enable some GNOME services
  services.upower.enable = true;
  services.accounts-daemon.enable = true;
  services.gnome.evolution-data-server.enable = true;
  services.gnome.glib-networking.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
}
