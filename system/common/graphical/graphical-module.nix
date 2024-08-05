{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.graphical;

  # Define the folder paths as variables
  waylandGnomePath = ./gnome;
  waylandHyprlandPath = ./hypr;
  waylandSwayPath = ./sway;
  xserverI3Path = ./i3;

  # Helper function to safely import modules
  safeImport = path: args: let
    imported = import path;
  in
    if isFunction imported
    then imported args
    else imported;
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
      lightSway.enable = mkOption {
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

      systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
          description = "polkit-gnome-authentication-agent-1";
          wantedBy = ["graphical-session.target"];
          wants = ["graphical-session.target"];
          after = ["graphical-session.target"];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };
        extraConfig = ''
          DefaultTimeoutStopSec=10s
        '';
      };
    })
    (mkIf (cfg.managers.enable || (!cfg.managers.gnome.enable && !cfg.managers.hyprland.enable && !cfg.managers.sway.enable && !cfg.managers.lightSway.enable && !cfg.managers.i3.enable)) (mkMerge [
      (mkIf (cfg.managers.gnome.enable || (!cfg.managers.hyprland.enable && !cfg.managers.sway.enable && !cfg.managers.lightSway.enable && !cfg.managers.i3.enable)) (safeImport waylandGnomePath {inherit config pkgs lib;}))
      (mkIf cfg.managers.hyprland.enable (safeImport waylandHyprlandPath {inherit config pkgs lib;}))
      (mkIf cfg.managers.sway.enable (safeImport waylandSwayPath {inherit config pkgs lib;}))
      (mkIf cfg.managers.lightSway.enable (safeImport waylandSwayPath {inherit config pkgs lib;}))
      (mkIf cfg.managers.i3.enable (safeImport xserverI3Path {inherit config pkgs lib;}))
    ]))
  ];
}
