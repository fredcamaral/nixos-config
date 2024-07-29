{
  config,
  lib,
  pkgs,
  hostname,
  desktop,
  laptop,
  ...
}: let
  # The modifier key used for Sway window management commands.
  # This is typically the "Super" or "Windows" key on most keyboards.
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
    }
    else if hostname == laptop
    then {
      "eDP-1" = {
        mode = "2880x1800@60Hz";
        position = "0,0";
        scale = "1.75";
        subpixel = "vrgb";
        adaptive_sync = true;
      };
    }
    else {};
in {
  imports = [
    ./waybar
    ./mako
    ./swayidle
    ./swaylock
    ./wlogout
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
        inner = 8;
        outer = 3;
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
          output = "DP-1";
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
          output = "DP-2";
        }
        {
          workspace = "9";
          output = "DP-2";
        }
        {
          workspace = "10";
          output = "DP-2";
        }
      ];
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+q" = "kill";
        "${modifier}+m" = "exec ${pkgs.wlogout}/bin/wlogout --protocol layer-shell";
        "${modifier}+e" = "exec ${pkgs.xfce.thunar}/bin/thunar";
        "${modifier}+space" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";
        "${modifier}+f" = "exec ${pkgs.firefox}/bin/firefox";
        "${modifier}+r" = "reload";
        "Ctrl+Alt+Delete" = "exit";
        "Print" = "exec ${pkgs.grim}/bin/grim -g '$(${pkgs.slurp}/bin/slurp)' ${config.xdg.userDirs.pictures}/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png";

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

        # Clipboard manager
        "${modifier}+v" = "exec ${pkgs.clipman}/bin/clipman pick -t wofi";

        # Modes Setting
        "${modifier}+Alt+r" = "mode resize";
        "${modifier}+Alt+l" = "mode launcher";
        "${modifier}+Alt+s" = "mode system";
        "${modifier}+Alt+t" = "mode layout";
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
      window = {
        border = 4;
        titlebar = false;

        commands = [
          # {
          #   command = "floating enable";
          #   criteria = {app_id = "pavucontrol";};
          # }
        ];
      };
      startup = [
        {command = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all";}
        {command = "${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";}
        {command = "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store";}
        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
        {command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";}
        {command = "swaymsg workspace 1";}
      ];
    };

    # Enables the swaynag utility, which provides a notification system for Sway, the i3-compatible Wayland compositor.
    swaynag = {
      enable = true;
    };

    # Sets the default floating border width to 2 pixels.
    extraConfig = ''
      #
    '';

    # This code sets up environment variables required for certain applications to work properly with the Wayland display server used by Sway, the i3-compatible Wayland compositor.
    # The `SDL_VIDEODRIVER=wayland` variable ensures that SDL (Simple DirectMedia Layer) applications use the Wayland backend.
    # The `QT_QPA_PLATFORM=wayland` and `QT_WAYLAND_DISABLE_WINDOWDECORATION="1"` variables configure Qt applications to use the Wayland display server and disable window decorations, respectively. Needs qt5.qtwayland in systemPackages.
    # The `_JAVA_AWT_WM_NONREPARENTING=1` variable is a fix for some Java AWT (Abstract Window Toolkit) applications, such as Android Studio, to ensure they are displayed properly.
    # The `QT_WAYLAND_DISABLE_WINDOWDECORATION="1"` variable is a fix for some Qt applications, such as Android Studio, to ensure they are displayed properly.
    # These environment variables are set in the `extraSessionCommands` section of the Sway configuration, which runs when the Sway session starts.
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
}
