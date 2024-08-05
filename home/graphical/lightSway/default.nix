{
  config,
  lib,
  pkgs,
  hostname,
  desktop,
  laptop-nixos,
  ...
}: let
  modifier = "Mod4";
  outputConfig =
    if hostname == desktop
    then {
      "DP-1" = {
        mode = "5120x1440@60Hz";
        position = "0,0";
        scale = "1.0";
      };
      "DP-2" = {
        mode = "2560x1440@60Hz";
        position = "3600,-1440";
        scale = "1.0";
      };
      "DP-3" = {
        mode = "2560x1440@60Hz";
        position = "-300,-1440";
        scale = "1.0";
      };
    }
    else if hostname == laptop-nixos
    then {
      "Virtual-1" = {
        mode = "2880x1800@120Hz";
        position = "0,0";
        scale = "1.0";
      };
    }
    else {};

  startupConfig =
    if hostname == desktop
    then {
      commands = [
        {command = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all";}
        {command = "${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";}
        {command = "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store";}
        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
        {command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";}
        {command = "swaymsg workspace 1";}
      ];
    }
    else if hostname == laptop-nixos
    then {
      commands = [
        {command = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all";}
        {command = "${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";}
        {command = "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store";}
        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
        {command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";}
        {command = "swaymsg workspace 1";}
      ];
    }
    else {};
in {
  imports = [
    ./waybar
    ./mako
    ./swayidle
    ./swaylock
    ./wofi
    ./dotfiles.nix
  ];

  services.mako.enable = true;

  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "${modifier}";
      terminal = "kitty";
      menu = "wofi --show drun";
      defaultWorkspace = "1";
      output = outputConfig;
      focus = {
        followMouse = true;
        mouseWarping = true;
      };
      gaps = {
        inner = 3;
        outer = 2;
      };
      bars = [
        {
          command = "waybar";
        }
      ];
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "intl";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
          dwt = "enabled";
          scroll_method = "two_finger";
          middle_emulation = "enabled";
        };
      };
      workspaceAutoBackAndForth = true;
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+q" = "kill";
        "${modifier}+e" = "exec ${pkgs.xfce.thunar}/bin/thunar";
        "${modifier}+space" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+b" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";
        "${modifier}+f" = "exec ${pkgs.firefox}/bin/firefox";
        "${modifier}+r" = "reload";
        "Ctrl+Alt+Delete" = "exit";
        "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | tee ${config.xdg.userDirs.pictures}/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | ${pkgs.wl-clipboard}/bin/wl-copy";

        # Switch to the specified workspace number.
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        # Move the focused container to the specified workspace number.
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Switch workspaces.
        "${modifier}+Alt+Right" = "workspace next";
        "${modifier}+Alt+Left" = "workspace prev";

        # Move the focused container to the specified output.
        "${modifier}+Right" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Up" = "focus up";
        "${modifier}+Down" = "focus down";

        # Resize the focused container.
        "${modifier}+Ctrl+Right" = "resize grow width 10 px";
        "${modifier}+Ctrl+Left" = "resize shrink width 10 px";
        "${modifier}+Ctrl+Up" = "resize grow height 10 px";
        "${modifier}+Ctrl+Down" = "resize shrink height 10 px";

        # Move the focused container.
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Down" = "move down";

        # Clipboard manager
        "${modifier}+v" = "exec ${pkgs.clipman}/bin/clipman pick -t wofi";
      };
      startup = startupConfig.commands;
    };

    # Enables the swaynag utility, which provides a notification system for Sway, the i3-compatible Wayland compositor.
    swaynag = {
      enable = true;
    };

    extraSessionCommands = ''
    '';
  };
}
