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
      num-workspaces = 5;
      workspace-names = ["Main" "Dev" "qBit" "Notes" "Misc"];
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
        "day-progress@arcaege.github.io"
        "monitor@astraext.github.io"
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
      legacy-tray-enabled = true;
      tray-pos = "right";
    };

    "org/gnome/shell/extensions/astra-monitor" = {
      compact-mode = false;
      current-profile = "main";
      gpu-header-activity-percentage = true;
      gpu-header-memory-percentage = true;
      gpu-header-show = false;
      gpu-indicators-order = "[\"icon\",\"activity bar\",\"activity graph\",\"activity percentage\",\"memory bar\",\"memory graph\",\"memory percentage\",\"memory value\"]";
      gpu-main = "\"\"";
      headers-height = 0;
      headers-height-override = 0;
      memory-header-bars = true;
      memory-header-bars-breakdown = false;
      memory-header-free = false;
      memory-header-percentage = true;
      memory-header-tooltip-free = true;
      memory-header-tooltip-percentage = false;
      memory-header-tooltip-value = false;
      memory-header-value = false;
      memory-indicators-order = "[\"icon\",\"bar\",\"graph\",\"percentage\",\"value\",\"free\"]";
      monitors-order = "[\"processor\",\"gpu\",\"memory\",\"storage\",\"network\",\"sensors\"]";
      network-header-bars = true;
      network-header-graph = false;
      network-header-io = true;
      network-header-tooltip = false;
      network-header-tooltip-io = false;
      network-indicators-order = "[\"icon\",\"IO bar\",\"IO graph\",\"IO speed\"]";
      panel-box = "left";
      processor-header-bars = true;
      processor-header-graph = false;
      processor-header-graph-breakdown = false;
      processor-header-percentage = true;
      processor-header-percentage-core = false;
      processor-header-tooltip = false;
      processor-header-tooltip-percentage = false;
      processor-header-tooltip-percentage-core = false;
      processor-indicators-order = "[\"icon\",\"bar\",\"graph\",\"percentage\"]";
      processor-menu-gpu-color = "";
      profiles = ''
        {"main":{"panel-margin-left":0,"sensors-header-tooltip-sensor2-digits":-1,"memory-update":3,"gpu-header-memory-graph-color1":"rgba(29,172,214,1.0)","panel-box":"left","memory-header-show":true,"network-header-tooltip-io":false,"processor-header-bars-color2":"rgba(214,29,29,1.0)","processor-header-icon-size":18,"storage-source-storage-io":"auto","sensors-header-tooltip-sensor4-name":"","storage-header-icon-color":"","network-source-public-ipv4":"https://api.ipify.org","storage-header-io-graph-color2":"rgba(214,29,29,1.0)","storage-header-io":true,"processor-menu-top-processes-percentage-core":true,"sensors-header-sensor1":"{\\"service\\":\\"sensors\\",\\"path\\":[\\"coretemp-isa-0000\\",\\"Package id 0\\",\\"temp1_input\\"]}","processor-header-graph":false,"storage-header-graph-width":30,"network-header-bars":true,"processor-source-load-avg":"auto","network-menu-arrow-color1":"rgba(29,172,214,1.0)","storage-header-io-graph-color1":"rgba(29,172,214,1.0)","gpu-header-icon":true,"processor-menu-graph-breakdown":true,"sensors-header-icon-custom":"","sensors-header-sensor2":"{\\"service\\":\\"sensors\\",\\"path\\":[\\"amdgpu-pci-0300\\",\\"edge\\",\\"temp1_input\\"]}","network-header-icon-alert-color":"rgba(235, 64, 52, 1)","memory-header-tooltip-free":true,"storage-header-io-figures":2,"network-menu-arrow-color2":"rgba(214,29,29,1.0)","sensors-header-tooltip-sensor3-name":"","network-source-public-ipv6":"https://api6.ipify.org","monitors-order":"\\"\\"","network-header-graph":false,"network-indicators-order":"\\"\\"","memory-header-percentage":true,"processor-header-tooltip":false,"gpu-main":"\\"\\"","storage-header-bars":true,"sensors-header-tooltip-sensor5-digits":-1,"memory-menu-swap-color":"rgba(29,172,214,1.0)","storage-io-unit":"kB/s","memory-header-graph-width":30,"processor-header-graph-color1":"rgba(29,172,214,1.0)","storage-header-tooltip-value":true,"gpu-header-icon-custom":"","processor-header-graph-breakdown":false,"panel-margin-right":0,"gpu-header-icon-size":18,"processor-source-cpu-usage":"auto","sensors-header-tooltip-sensor3-digits":-1,"sensors-header-icon":true,"memory-header-value-figures":3,"processor-header-graph-color2":"rgba(214,29,29,1.0)","compact-mode":false,"panel-box-order":0,"compact-mode-compact-icon-custom":"","network-header-graph-width":30,"gpu-header-tooltip":true,"sensors-header-icon-alert-color":"rgba(235, 64, 52, 1)","gpu-header-activity-percentage-icon-alert-threshold":0,"sensors-header-sensor2-digits":-1,"sensors-header-tooltip-sensor2-name":"","sensors-update":3,"gpu-header-tooltip-memory-value":true,"processor-header-bars":true,"gpu-header-memory-bar-color1":"rgba(29,172,214,1.0)","gpu-header-tooltip-memory-percentage":true,"sensors-header-tooltip-sensor1":"\\"\\"","sensors-header-tooltip-sensor1-digits":-1,"storage-header-free-figures":3,"processor-header-percentage-core":false,"storage-main":"[default]","network-source-network-io":"auto","memory-header-bars":true,"processor-header-percentage":true,"sensors-header-icon-color":"","storage-header-io-threshold":0,"memory-header-graph-color1":"rgba(29,172,214,1.0)","compact-mode-activation":"both","storage-header-icon-size":18,"sensors-header-tooltip-sensor1-name":"","sensors-header-icon-size":18,"sensors-source":"auto","explicit-zero":false,"storage-header-percentage-icon-alert-threshold":0,"storage-header-tooltip-io":false,"sensors-header-tooltip-sensor2":"\\"\\"","compact-mode-expanded-icon-custom":"","memory-header-graph-color2":"rgba(29,172,214,0.3)","processor-header-icon-alert-color":"rgba(235, 64, 52, 1)","processor-header-tooltip-percentage":false,"gpu-header-show":false,"network-update":1.5,"sensors-header-tooltip-sensor3":"\\"\\"","storage-header-free-icon-alert-threshold":0,"memory-header-icon-custom":"","sensors-header-tooltip-sensor4":"\\"\\"","storage-header-percentage":false,"sensors-temperature-unit":"celsius","storage-header-icon-alert-color":"rgba(235, 64, 52, 1)","storage-menu-arrow-color2":"rgba(214,29,29,1.0)","memory-source-top-processes":"auto","storage-header-value-figures":3,"storage-header-io-bars-color1":"rgba(29,172,214,1.0)","storage-menu-arrow-color1":"rgba(29,172,214,1.0)","processor-header-graph-width":30,"network-header-icon-custom":"","gpu-header-tooltip-activity-percentage":true,"network-header-icon":true,"sensors-header-sensor2-layout":"vertical","sensors-header-tooltip-sensor5":"\\"\\"","memory-header-bars-breakdown":false,"sensors-header-show":true,"sensors-header-tooltip":false,"storage-update":3,"processor-header-bars-core":false,"storage-indicators-order":"\\"\\"","processor-menu-bars-breakdown":true,"storage-header-io-bars-color2":"rgba(214,29,29,1.0)","network-io-unit":"kB/s","storage-header-icon":true,"gpu-header-activity-graph-color1":"rgba(29,172,214,1.0)","memory-unit":"kB-kiB","processor-menu-core-bars-breakdown":true,"sensors-header-sensor2-show":true,"network-header-tooltip":false,"storage-header-tooltip-free":true,"storage-header-bars-color1":"rgba(29,172,214,1.0)","theme-style":"dark","storage-source-storage-usage":"auto","network-header-io":true,"memory-header-tooltip-percentage":false,"memory-indicators-order":"\\"\\"","memory-source-memory-usage":"auto","memory-header-graph-breakdown":false,"memory-header-tooltip-value":false,"memory-menu-graph-breakdown":true,"sensors-indicators-order":"\\"\\"","compact-mode-start-expanded":false,"startup-delay":2,"memory-header-percentage-icon-alert-threshold":0,"sensors-header-sensor1-show":true,"network-ignored-regex":"","memory-header-value":false,"memory-header-bars-color1":"rgba(29,172,214,1.0)","network-header-io-graph-color1":"rgba(29,172,214,1.0)","gpu-header-memory-bar":true,"memory-used":"total-free-buffers-cached","gpu-header-memory-graph-width":30,"gpu-header-memory-graph":false,"headers-font-family":"","memory-header-icon":true,"network-header-io-graph-color2":"rgba(214,29,29,1.0)","memory-header-bars-color2":"rgba(29,172,214,0.3)","processor-gpu":true,"network-header-icon-color":"","storage-header-value":false,"gpu-header-icon-alert-color":"rgba(235, 64, 52, 1)","processor-header-icon":true,"headers-font-size":0,"network-header-io-figures":2,"network-header-show":true,"storage-header-tooltip":true,"network-header-io-bars-color1":"rgba(29,172,214,1.0)","processor-update":1.5,"network-source-wireless":"auto","processor-indicators-order":"\\"\\"","storage-header-icon-custom":"","gpu-header-activity-bar":true,"gpu-header-activity-bar-color1":"rgba(29,172,214,1.0)","shell-bar-position":"top","network-ignored":"\\"[]\\"","network-header-io-bars-color2":"rgba(214,29,29,1.0)","memory-header-icon-color":"","sensors-header-sensor1-digits":0,"storage-header-io-layout":"vertical","memory-header-icon-size":18,"network-header-io-threshold":0,"storage-header-show":true,"sensors-header-tooltip-sensor4-digits":-1,"processor-header-percentage-icon-alert-threshold":0,"memory-header-tooltip":true,"headers-height-override":0,"memory-header-graph":false,"network-header-icon-size":18,"gpu-header-icon-color":"","memory-header-free-figures":3,"storage-header-io-bars":false,"processor-header-bars-breakdown":true,"gpu-header-activity-graph":false,"storage-ignored":"\\"[]\\"","memory-header-icon-alert-color":"rgba(235, 64, 52, 1)","storage-header-free":false,"processor-header-icon-custom":"","gpu-header-memory-percentage":true,"processor-header-tooltip-percentage-core":false,"processor-source-cpu-cores-usage":"auto","processor-source-top-processes":"auto","processor-header-icon-color":"","sensors-header-tooltip-sensor5-name":"","gpu-header-activity-graph-width":30,"gpu-header-activity-percentage":true,"gpu-indicators-order":"\\"\\"","processor-header-bars-color1":"rgba(29,172,214,1.0)","gpu-update":1.5,"gpu-header-memory-percentage-icon-alert-threshold":0,"network-header-io-layout":"vertical","processor-header-show":true,"storage-header-graph":false,"memory-header-free-icon-alert-threshold":0,"storage-ignored-regex":"","storage-menu-device-color":"rgba(29,172,214,1.0)","storage-header-tooltip-percentage":true,"memory-header-free":false,"storage-source-top-processes":"auto"}}
      '';
      sensors-header-sensor1 = ''
        {"service":"sensors","path":["coretemp-isa-0000","Package id 0","temp1_input"]}
      '';
      sensors-header-sensor1-digits = 0;
      sensors-header-sensor1-show = true;
      sensors-header-sensor2 = ''
        {"service":"sensors","path":["amdgpu-pci-0300","edge","temp1_input"]}
      '';
      sensors-header-sensor2-layout = "vertical";
      sensors-header-sensor2-show = true;
      sensors-header-show = true;
      sensors-indicators-order = "[\"icon\",\"value\"]";
      storage-header-bars = true;
      storage-header-io = true;
      storage-header-percentage = false;
      storage-header-tooltip = true;
      storage-header-tooltip-free = true;
      storage-header-tooltip-io = false;
      storage-header-tooltip-percentage = true;
      storage-header-tooltip-value = true;
      storage-indicators-order = "[\"icon\",\"bar\",\"percentage\",\"value\",\"free\",\"IO bar\",\"IO graph\",\"IO speed\"]";
      storage-main = "GIGABYTE_GP-AG4500G_SN203108962484-part2";
      theme-style = "dark";
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
      position = "left";
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
