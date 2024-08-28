{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    "XDG_CURRENT_DESKTOP" = "Hyprland";
    "XDG_SESSION_TYPE" = "wayland";
    "QT_QPA_PLATFORM" = "wayland";
    "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
    "GDK_BACKEND" = "wayland";
    "MOZ_ENABLE_WAYLAND" = "1";
    "CLUTTER_BACKEND" = "wayland";
    "SDL_VIDEODRIVER" = "wayland";
    "WLR_NO_HARDWARE_CURSORS" = "1";
  };

  services.xserver.enable = false;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
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
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    waybar
    dunst
    rofi-wayland
  ];
}
