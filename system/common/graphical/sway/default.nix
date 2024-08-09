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

  services = {
    dbus.enable = true;
    xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        enableHidpi = true;
      };
    };
    gnome.gnome-keyring.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  environment.systemPackages = with pkgs; [
    libnotify # for notifications
    polkit # for permission management
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
