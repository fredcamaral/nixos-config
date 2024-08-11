{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  environment.sessionVariables = {
    "XDG_CURRENT_DESKTOP" = "sway";
    "XDG_SESSION_TYPE" = "wayland";
    "QT_QPA_PLATFORM" = "wayland";
    "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
    "GDK_BACKEND" = "wayland";
    "MOZ_ENABLE_WAYLAND" = "1";
    "CLUTTER_BACKEND" = "wayland";
    "SDL_VIDEODRIVER" = "wayland";
    "WLR_DRM_NO_ATOMIC" = "1";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.enable = false;

  #xdg.portal = {
  #  enable = true;
  #  wlr.enable = true;
  #  extraPortals = [pkgs.xdg-desktop-portal-gtk];
  #};

  environment.systemPackages = with pkgs; [
    libnotify # for notifications
    polkit_gnome # for permission management
    qt5.qtwayland # for Qt applications
    qt6.qtwayland # for Qt applications
    wlogout # for logout notifications
    gtk3 # for GTK applications
    gtk4 # for GTK applications
    glib # for GTK applications
    gsettings-desktop-schemas # for GTK applications
    seahorse # for GNOME applications
    xdg-utils # for XDG applications
  ];
}
