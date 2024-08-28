{
  config,
  lib,
  pkgs,
  hostname,
  desktop,
  ...
}: let
  modifier = "SUPER";
  outputConfig =
    if hostname == desktop
    then [
      "DP-1,5120x1440@240,0x0,1"
      "DP-2,2560x1440@60,3600x-1440,1"
      "DP-3,2560x1440@60,-300x-1440,1"
    ]
    else [];

  startupConfig =
    if hostname == desktop
    then [
      "exec-once = nm-applet --indicator"
      "exec-once = blueman-applet"
      "workspace = 1"
    ]
    else [];
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

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "${modifier}";
      monitor = outputConfig;
      exec-once = startupConfig;

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          disable_while_typing = true;
        };
      };

      general = {
        gaps_in = 4;
        gaps_out = 2;
        border_size = 4;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = true;
        blur_size = 3;
        blur_passes = 1;
        blur_new_optimizations = true;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
        "$mod, q, killactive"
        "$mod, m, exec, ${pkgs.wlogout}/bin/wlogout --protocol layer-shell"
        "$mod, e, exec, ${pkgs.xfce.thunar}/bin/thunar"
        "$mod, space, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "$mod, b, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "$mod, l, exec, ${pkgs.swaylock-effects}/bin/swaylock"
        "$mod, f, exec, ${pkgs.firefox}/bin/firefox"
        "$mod, r, exec, hyprctl reload"
        "CTRL ALT, Delete, exit"
        ", Print, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | tee ${config.xdg.userDirs.pictures}/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | ${pkgs.wl-clipboard}/bin/wl-copy"
        "$mod SHIFT, v, togglefloating"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod ALT, right, workspace, e+1"
        "$mod ALT, left, workspace, e-1"
        "$mod, right, movefocus, r"
        "$mod, left, movefocus, l"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod CTRL, right, resizeactive, 10 0"
        "$mod CTRL, left, resizeactive, -10 0"
        "$mod CTRL, up, resizeactive, 0 -10"
        "$mod CTRL, down, resizeactive, 0 10"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        ", XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ", XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioMicMute, exec, ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
        ", XF86LaunchA, exec, ${pkgs.wofi}/bin/wofi --show drun"
        ", XF86LaunchB, exec, ${pkgs.firefox}/bin/firefox"
        ", XF86KbdBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl --device='smc::kbd_backlight' set 5%-"
        ", XF86KbdBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl --device='smc::kbd_backlight' set +5%"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        "$mod, v, exec, ${pkgs.clipman}/bin/clipman pick -t wofi"
      ];

      windowrulev2 = [
        "float,class:^(pavucontrol)$"
        "float,class:^(blueman-manager)$"
        "float,title:^(File Operation Progress)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(Open File)$"
      ];
    };

    extraConfig = ''
      exec-once = dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
      exec-once = systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
    '';
  };
}
