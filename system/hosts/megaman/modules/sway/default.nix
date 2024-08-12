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

  services.xserver.enable = false;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libnotify
    polkit_gnome
    qt5.qtwayland
    qt6.qtwayland
    wlogout
    gtk3
    gtk4
    glib
    gsettings-desktop-schemas
    seahorse
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-wlr
  ];
}
