{
  config,
  pkgs,
  ...
}: {
  services = {
    xserver.displayManager.lightdm.enable = false;
    xserver.displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --primary
    '';
    displayManager = {
      sddm = {
        enable = true;
        theme = "catppuccin-macchiato";
        settings = {
          General = {
            DisplayServer = "wayland";
            InputMethod = "";
          };
          X11 = {
            ServerArguments = "-nolisten tcp -background none";
            EnableHiDPI = true;
          };
          Wayland = {
            EnableHiDPI = true;
          };
        };
      };
    };
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = false;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    hyprlock.enable = true;
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    WLR_PRIMARY_SELECTION = "clipboard";
  };
}
