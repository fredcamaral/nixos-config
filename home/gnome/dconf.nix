# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{
  lib,
  pkgs,
  ...
}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      begin-move = [];
      begin-resize = [];
      close = ["<Super>q"];
      cycle-group = [];
      cycle-group-backward = [];
      cycle-panels = [];
      cycle-panels-backward = [];
      cycle-windows = [];
      cycle-windows-backward = [];
      maximize = [];
      minimize = [];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-workspace-1 = ["<Alt><Super>1"];
      move-to-workspace-2 = ["<Alt><Super>2"];
      move-to-workspace-3 = ["<Alt><Super>3"];
      move-to-workspace-4 = ["<Alt><Super>4"];
      move-to-workspace-5 = ["<Alt><Super>5"];
      move-to-workspace-6 = ["<Alt><Super>6"];
      move-to-workspace-last = [];
      move-to-workspace-left = [];
      move-to-workspace-right = [];
      panel-run-dialog = ["<Super>r"];
      switch-applications = ["<Alt>Tab"];
      switch-applications-backward = ["<Shift><Alt>Tab"];
      switch-group = [];
      switch-group-backward = [];
      switch-input-source = [];
      switch-input-source-backward = [];
      switch-panels = [];
      switch-panels-backward = [];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-last = [];
      switch-to-workspace-left = ["<Alt><Super>Left"];
      switch-to-workspace-right = ["<Alt><Super>Right"];
      switch-windows = ["<Super>Tab"];
      switch-windows-backward = ["<Shift><Super>Tab"];
      toggle-maximized = [];
      unmaximize = [];
    };

    "org/gnome/desktop/wm/preferences" = {
      action-middle-click-titlebar = "none";
      focus-mode = "click";
      num-workspaces = 4;
      workspace-names = ["Main" "Dev" "qBit" "Misc"];
    };

    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      calculator = ["<Super>c"];
      control-center = ["<Super>s"];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
      help = [];
      home = ["<Super>e"];
      logout = [];
      magnifier = [];
      magnifier-zoom-in = [];
      magnifier-zoom-out = [];
      mic-mute = ["<Super>m"];
      next = ["AudioNext"];
      play = ["AudioPlay"];
      previous = ["AudioPrev"];
      screenreader = [];
      search = ["<Super>space"];
      volume-down = ["AudioLowerVolume"];
      volume-mute = ["AudioMute"];
      volume-up = ["AudioRaiseVolume"];
      www = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "${pkgs.kitty}/bin/kitty --class misc";
      name = "Kitty";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>f";
      command = "${pkgs.firefox}/bin/firefox --class misc";
      name = "Firefox";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>x";
      command = "/run/current-system/sw/bin/gnome-extensions-app";
      name = "Gnome Extensions";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "nothing";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      disable-extension-version-validation = true;
      disable-user-extensions = false;
      enabled-extensions = [
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "gTile@vibou"
        "space-bar@luchrioh"
        "focus-changer@heartmire"
        "appindicatorsupport@rgcjonas.gmail.com"
        "dim-background-windows@stephane-13.github.com"
      ];
      last-selected-power-profile = "performance";
    };

    "org/gnome/shell/extensions/dim-background-windows" = {
      brightness = 0.6;
      dimming-enabled = true;
      toggle-shortcut = ["<Super>g"];
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-size = 16;
    };

    "org/gnome/shell/extensions/focus-changer" = {
      focus-down = ["<Super>Down"];
      focus-left = ["<Super>Left"];
      focus-right = ["<Super>Right"];
      focus-up = ["<Super>Up"];
    };

    "org/gnome/shell/extensions/gtile" = {
      action-contract-bottom = [];
      action-contract-left = [];
      action-contract-right = [];
      action-contract-top = [];
      autotile-1 = ["<Alt><Super>1"];
      autotile-10 = ["<Alt><Super>0"];
      autotile-2 = ["<Alt><Super>2"];
      autotile-3 = ["<Alt><Super>3"];
      autotile-4 = ["<Alt><Super>4"];
      autotile-5 = ["<Alt><Super>5"];
      autotile-6 = ["<Alt><Super>6"];
      autotile-7 = ["<Alt><Super>7"];
      autotile-8 = ["<Alt><Super>8"];
      autotile-9 = ["<Alt><Super>9"];
      autotile-main = [];
      global-auto-tiling = false;
      grid-sizes = "10x2";
      insets-primary-bottom = 4;
      insets-primary-left = 4;
      insets-primary-right = 4;
      insets-primary-top = 4;
      moveresize-enabled = false;
      show-icon = false;
      show-toggle-tiling = ["<Super>backslash"];
      theme = "Classic";
      window-spacing = 4;
    };

    "org/gnome/shell/extensions/space-bar/appearance" = {
      active-workspace-text-color = "rgb(246,211,45)";
      empty-workspace-text-color = "rgb(94,92,100)";
    };

    "org/gnome/shell/extensions/space-bar/behavior" = {
      always-show-numbers = true;
      indicator-style = "workspaces-bar";
      show-empty-workspaces = true;
    };

    "org/gnome/shell/extensions/space-bar/shortcuts" = {
      enable-move-to-workspace-shortcuts = true;
    };

    "org/gnome/shell/extensions/space-bar/state" = {
      version = 27;
    };

    "org/gnome/shell/extensions/system-monitor" = {
      show-swap = false;
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [];
      show-screenshot-ui = ["Print"];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      toggle-application-view = [];
      toggle-message-tray = [];
      toggle-overview = [];
      toggle-quick-settings = [];
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
  };
}
