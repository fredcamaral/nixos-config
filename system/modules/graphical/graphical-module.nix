{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.graphical;

  # Define the folder paths as variables
  waylandGnomePath = ./wayland-and-gnome;
  waylandHyprlandPath = ./wayland-and-hyprland;
  waylandSwayPath = ./wayland-and-sway;
  xserverI3Path = ./xserver-and-i3;
in {
  options.graphical = {
    xdefaults.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable X-Server default options (xkb, xterm, etc.)";
    };
    managers.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable graphical environment";
    };
    managers = {
      gnome.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable GNOME desktop environment";
      };
      hyprland.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Hyprland desktop environment";
      };
      sway.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Sway window manager";
      };
      i3.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable i3 window manager";
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.xdefaults.enable {
      services.xserver = {
        enable = true;
        xkb.layout = "us";
        xkb.variant = "intl";
        desktopManager.xterm.enable = false;
      };
    })
    (mkIf (cfg.managers.enable || (!cfg.managers.gnome.enable && !cfg.managers.hyprland.enable && !cfg.managers.sway.enable && !cfg.managers.i3.enable)) (mkMerge [
      (mkIf (cfg.managers.gnome.enable || (!cfg.managers.hyprland.enable && !cfg.managers.sway.enable && !cfg.managers.i3.enable)) (import waylandGnomePath {inherit config pkgs lib;}))
      (mkIf cfg.managers.hyprland.enable (import waylandHyprlandPath {inherit config pkgs lib;}))
      (mkIf cfg.managers.sway.enable (import waylandSwayPath {inherit config pkgs lib;}))
      (mkIf cfg.managers.i3.enable (import xserverI3Path {inherit config pkgs lib;}))
    ]))
  ];
}
