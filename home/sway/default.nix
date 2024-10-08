{
  config,
  lib,
  pkgs,
  hostname,
  desktop,
  ...
}: let
  modifier = "Mod4";
  outputConfig =
    if hostname == desktop
    then {
      "DP-1" = {
        mode = "5120x1440@240Hz";
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
    else {};

  startupConfig =
    if hostname == desktop
    then {
      commands = [
        {command = "nm-applet --indicator";}
        {command = "blueman-applet";}
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
        inner = 4;
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
      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-1";
        }
        {
          workspace = "2";
          output = "DP-1";
        }
        {
          workspace = "3";
          output = "DP-1";
        }
        {
          workspace = "4";
          output = "DP-1";
        }
        {
          workspace = "5";
          output = "DP-2";
        }
        {
          workspace = "6";
          output = "DP-2";
        }
        {
          workspace = "7";
          output = "DP-2";
        }
        {
          workspace = "8";
          output = "DP-3";
        }
        {
          workspace = "9";
          output = "DP-3";
        }
        {
          workspace = "10";
          output = "DP-3";
        }
      ];
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+q" = "kill";
        "${modifier}+m" = "exec ${pkgs.wlogout}/bin/wlogout --protocol layer-shell";
        "${modifier}+e" = "exec ${pkgs.xfce.thunar}/bin/thunar";
        "${modifier}+space" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+b" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";
        "${modifier}+f" = "exec ${pkgs.firefox}/bin/firefox";
        "${modifier}+r" = "reload";
        "Ctrl+Alt+Delete" = "exit";
        "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | tee ${config.xdg.userDirs.pictures}/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | ${pkgs.wl-clipboard}/bin/wl-copy";

        # Floating toggle
        "${modifier}+Shift+v" = "floating toggle";

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

        # Media controls
        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioMicMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
        "XF86LaunchA" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "XF86LaunchB" = "exec ${pkgs.firefox}/bin/firefox";
        "XF86KbdBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl --device='smc::kbd_backlight' set 5%-";
        "XF86KbdBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl --device='smc::kbd_backlight' set +5%";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86Sleep" = "exec";
        "XF86PowerOff" = "exec";

        # Clipboard manager
        "${modifier}+v" = "exec ${pkgs.clipman}/bin/clipman pick -t wofi";

        # Modes Setting
        "${modifier}+Alt+r" = "mode resize";
        "${modifier}+Alt+l" = "mode launcher";
        "${modifier}+Alt+s" = "mode system";
        "${modifier}+t" = "mode layout";
      };
      modes = {
        resize = {
          "Left" = "resize shrink width 10px";
          "Down" = "resize grow height 10px";
          "Up" = "resize shrink height 10px";
          "Right" = "resize grow width 10px";
          "Escape" = "mode default";
          "Return" = "mode default";
        };
        launcher = {
          "f" = "exec firefox; mode default";
          "c" = "exec code; mode default";
          "t" = "exec telegram-desktop; mode default";
          "s" = "exec slack; mode default";
          "Escape" = "mode default";
        };
        system = {
          "l" = "exec swaylock; mode default";
          "e" = "exec swaymsg exit";
          "s" = "exec systemctl poweroff";
          "r" = "exec systemctl reboot";
          "Escape" = "mode default";
        };
        layout = {
          "c" = "layout splith, focus left, resize set width 25ppt, focus right, resize set width 50ppt, focus right, resize set width 25ppt, focus left, focus left, resize set width 25ppt, focus right, resize set width 50ppt, focus right, resize set width 25ppt, focus left; mode default";
          "x" = "layout splith, focus left, resize set width 25ppt, focus right, resize set width 75ppt, focus right; mode default";
          "s" = "layout stacking";
          "t" = "layout tabbed";
          "p" = "layout toggle split";
          "Escape" = "mode default";
        };
      };
      floating = {
        border = 4;
        titlebar = false;
        criteria = [
          {app_id = "pavucontrol";}
          {app_id = "blueman-manager";}
          {title = "File Operation Progress";}
          {title = "Confirm to replace files";}
          {title = "^Open File$";}
        ];
      };
      startup = startupConfig.commands;
    };

    # Enables the swaynag utility, which provides a notification system for Sway, the i3-compatible Wayland compositor.
    swaynag = {
      enable = true;
    };

    extraConfig = ''
      exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
      exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
    '';
  };
}
