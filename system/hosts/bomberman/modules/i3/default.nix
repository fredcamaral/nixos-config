{
  pkgs,
  lib,
  ...
}: let
  modifier = "Mod4";
  terminal = "${pkgs.kitty}/bin/kitty";
  menu = "${pkgs.wofi}/bin/wofi --show drun";
in {
  services = {
    displayManager.sddm.enable = true;
    xserver.windowManager.i3.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  programs.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "${modifier}";
      terminal = "${terminal}";
      menu = "${menu}";
      fonts = {
        names = ["monospace"];
        size = 8.0;
      };
      floating = {
        modifier = "Mod4";
        border = 4;
        criteria = [
          {class = "pavucontrol";}
          {class = "blueman-manager";}
          {title = "File Operation Progress";}
          {title = "Confirm to replace files";}
          {title = "^Open File$";}
        ];
      };
      gaps = {
        inner = 4;
        outer = 2;
      };
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+q" = "kill";
        "${modifier}+m" = "exec ${pkgs.wlogout}/bin/wlogout --protocol layer-shell";
        "${modifier}+e" = "exec ${pkgs.xfce.thunar}/bin/thunar";
        "${modifier}+space" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+b" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+l" = "exec ${pkgs.i3lock}/bin/i3lock";
        "${modifier}+f" = "exec ${pkgs.firefox}/bin/firefox";
        "${modifier}+r" = "reload";
        "Ctrl+Alt+Delete" = "exit";
        "Print" = "exec ${pkgs.scrot}/bin/scrot -s ~/Pictures/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png -e 'xclip -selection clipboard -t image/png -i $f'";
        "${modifier}+Shift+v" = "floating toggle";
        "${modifier}+Right" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Up" = "focus up";
        "${modifier}+Down" = "focus down";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Down" = "move down";
        "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "${modifier}+v" = "exec ${pkgs.clipman}/bin/clipman pick -t wofi";
        "${modifier}+Alt+r" = "mode resize";
        "${modifier}+Alt+l" = "mode launcher";
        "${modifier}+Alt+s" = "mode system";
        "${modifier}+t" = "mode layout";
      };
      modes = {
        resize = {
          "Left" = "resize shrink width 10 px";
          "Down" = "resize grow height 10 px";
          "Up" = "resize shrink height 10 px";
          "Right" = "resize grow width 10 px";
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
          "l" = "exec ${pkgs.i3lock}/bin/i3lock; mode default";
          "e" = "exec i3-msg exit";
          "s" = "exec systemctl poweroff";
          "r" = "exec systemctl reboot";
          "Escape" = "mode default";
        };
        layout = {
          "c" = "layout splith; mode default";
          "x" = "layout splith; mode default";
          "s" = "layout stacking; mode default";
          "t" = "layout tabbed; mode default";
          "p" = "layout toggle split; mode default";
          "Escape" = "mode default";
        };
      };
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];
      startup = [
        {command = "${pkgs.networkmanagerapplet}/bin/nm-applet";}
        {command = "${pkgs.blueman}/bin/blueman-applet";}
        {command = "i3-msg workspace 1";}
      ];
    };

    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      i3blocks
    ];

    extraConfig = ''
      focus_wrapping no
    '';
  };

  # Additional system-wide configurations
  environment.systemPackages = with pkgs; [
    kitty
    wofi
    firefox
    xfce.thunar
    wlogout
    scrot
    pulseaudio
    brightnessctl
    playerctl
    clipman
  ];
}
