{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.graphical;
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
      (mkIf (cfg.managers.gnome.enable || (!cfg.managers.hyprland.enable && !cfg.managers.sway.enable && !cfg.managers.i3.enable)) (import ./wayland-and-gnome.nix {inherit config pkgs lib;}))
      (mkIf cfg.managers.hyprland.enable (import ./wayland-and-hyprland.nix {inherit config pkgs lib;}))
      (mkIf cfg.managers.sway.enable (import ./wayland-and-sway.nix {inherit config pkgs lib;}))
      (mkIf cfg.managers.i3.enable (import ./xserver-and-i3.nix {inherit config pkgs lib;}))
    ]))
  ];
}
