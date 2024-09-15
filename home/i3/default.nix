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
      };
      "DP-2" = {
        mode = "2560x1440@60Hz";
        position = "3600,-1440";
      };
      "DP-3" = {
        mode = "2560x1440@60Hz";
        position = "-300,-1440";
      };
    }
    else {};

  startupConfig =
    if hostname == desktop
    then [
      {command = "${pkgs.networkmanagerapplet}/bin/nm-applet";}
      {command = "${pkgs.blueman}/bin/blueman-applet";}
      {command = "i3-msg workspace 1";}
    ]
    else [];
in {
  imports = [
    ./polybar
    ./dunst
    ./rofi
    ./dotfiles.nix
  ];

  services.dunst.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      modifier = "${modifier}";
      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "${pkgs.rofi}/bin/rofi -show drun";
      defaultWorkspace = "workspace number 1";
      workspaceAutoBackAndForth = true;

      fonts = {
        names = ["DejaVu Sans Mono"];
        size = 10.0;
      };

      gaps = {
        inner = 4;
        outer = 2;
      };

      bars = []; # We'll use polybar instead

      focus = {
        followMouse = true;
        mouseWarping = true;
      };

      # assigns = {
      #   "1" = [{criteria = {output = "DP-1";};}];
      #   "2" = [{criteria = {output = "DP-1";};}];
      #   "3" = [{criteria = {output = "DP-1";};}];
      #   "4" = [{criteria = {output = "DP-1";};}];
      #   "5" = [{criteria = {output = "DP-2";};}];
      #   "6" = [{criteria = {output = "DP-2";};}];
      #   "7" = [{criteria = {output = "DP-2";};}];
      #   "8" = [{criteria = {output = "DP-3";};}];
      #   "9" = [{criteria = {output = "DP-3";};}];
      #   "10" = [{criteria = {output = "DP-3";};}];
      # };

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+q" = "kill";
        "${modifier}+m" = "exec ${pkgs.i3}/bin/i3-nagbar -t warning -m 'Log out?' -B 'Yes' 'i3-msg exit'";
        "${modifier}+e" = "exec ${pkgs.xfce.thunar}/bin/thunar";
        "${modifier}+space" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+b" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+l" = "exec ${pkgs.i3lock-fancy}/bin/i3lock-fancy";
        "${modifier}+f" = "exec ${pkgs.firefox}/bin/firefox";
        "${modifier}+r" = "reload";
        "Ctrl+Alt+Delete" = "exit";
        "Print" = "exec ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";

        "${modifier}+Shift+v" = "floating toggle";

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

        "${modifier}+Alt+Right" = "workspace next";
        "${modifier}+Alt+Left" = "workspace prev";

        "${modifier}+Right" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Up" = "focus up";
        "${modifier}+Down" = "focus down";

        "${modifier}+Ctrl+Right" = "resize grow width 10 px or 10 ppt";
        "${modifier}+Ctrl+Left" = "resize shrink width 10 px or 10 ppt";
        "${modifier}+Ctrl+Up" = "resize grow height 10 px or 10 ppt";
        "${modifier}+Ctrl+Down" = "resize shrink height 10 px or 10 ppt";

        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Down" = "move down";

        "${modifier}+v" = "exec ${pkgs.clipmenu}/bin/clipmenu";
      };

      startup = startupConfig;
    };

    extraConfig = ''
      exec_always --no-startup-id ${pkgs.polybar}/bin/polybar
      exec_always --no-startup-id ${pkgs.picom}/bin/picom -b
      exec_always --no-startup-id ${pkgs.xorg.xset}/bin/xset r rate 200 40
      exec_always --no-startup-id ${pkgs.dex}/bin/dex -a -s /etc/xdg/autostart/:~/.config/autostart/
    '';
  };

  services.picom = {
    enable = true;
    vSync = true;
    backend = "glx";
  };

  services.xidlehook = {
    enable = true;
    not-when-fullscreen = true;
    timers = [
      {
        delay = 300;
        command = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
      }
    ];
  };

  home.packages = with pkgs; [
    i3-gaps
    i3lock-fancy
    # polybar
    rofi
    dunst
    maim
    xclip
    feh
    picom
    dex
    xorg.xset
    brightnessctl
    playerctl
    clipmenu
    xfce.thunar
    libnotify
    qt5ct
    gtk3
    gtk4
    glib
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];
}
