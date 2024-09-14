{
  lib,
  config,
  pkgs,
  ...
}: {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    script = "polybar main &";
    config = {
      "bar/main" = {
        monitor = "DP-1";
        width = "100%";
        height = 36;
        background = "#282A2E";
        foreground = "#C5C8C6";
        line-size = 3;
        line-color = "#f00";
        border-size = 0;
        border-color = "#00000000";
        padding-left = 0;
        padding-right = 2;
        module-margin-left = 1;
        module-margin-right = 2;
        font-0 = "DejaVu Sans Mono:pixelsize=10;1";
        font-1 = "Font Awesome 5 Free:style=Solid:pixelsize=10;1";
        font-2 = "Font Awesome 5 Brands:pixelsize=10;1";
        modules-left = "i3 xwindow";
        modules-center = "";
        modules-right = "cpu temperature memory gpu-usage pulseaudio xkeyboard date";
        tray-position = "right";
        tray-padding = 2;
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;
        label-mode-padding = 2;
        label-mode-foreground = "#000";
        label-mode-background = "#ffb52a";
        label-focused = "%index%";
        label-focused-background = "#3f3f3f";
        label-focused-underline = "#fba922";
        label-focused-padding = 2;
        label-unfocused = "%index%";
        label-unfocused-padding = 2;
        label-visible = "%index%";
        label-visible-background = "#3f3f3f";
        label-visible-underline = "#555555";
        label-visible-padding = 2;
        label-urgent = "%index%";
        label-urgent-background = "#bd2c40";
        label-urgent-padding = 2;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:30:...%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = " ";
        format-prefix-foreground = "#5b";
        label = "CPU %percentage:2%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = " ";
        format-prefix-foreground = "#4bffdc";
        label = "RAM %percentage_used%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        format-prefix = " ";
        format-prefix-foreground = "#5b";
        label = "%date% %time%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<label-volume> <bar-volume>";
        label-volume = "VOL %percentage%%";
        label-volume-foreground = "#ff";
        label-muted = "🔇 muted";
        label-muted-foreground = "#666";
        bar-volume-width = 10;
        bar-volume-foreground-0 = "#55aa55";
        bar-volume-foreground-1 = "#55aa55";
        bar-volume-foreground-2 = "#55aa55";
        bar-volume-foreground-3 = "#55aa55";
        bar-volume-foreground-4 = "#55aa55";
        bar-volume-foreground-5 = "#f5a70a";
        bar-volume-foreground-6 = "#ff5555";
        bar-volume-gradient = false;
        bar-volume-indicator = "|";
        bar-volume-indicator-font = 2;
        bar-volume-fill = "─";
        bar-volume-fill-font = 2;
        bar-volume-empty = "─";
        bar-volume-empty-font = 2;
        bar-volume-empty-foreground = "#44";
      };

      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;
        warn-temperature = 60;
        format = "<ramp> <label>";
        format-warn = "<ramp> <label-warn>";
        label = "TEMP %temperature-c%";
        label-warn = "TEMP %temperature-c%";
        label-warn-foreground = "#f00";
        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
        ramp-foreground = "#66";
      };

      "module/gpu-usage" = {
        type = "custom/script";
        exec = "${pkgs.lm_sensors}/bin/sensors -j amdgpu-pci-0300 | ${pkgs.jq}/bin/jq '.\"amdgpu-pci-0300\".PPT.power1_average | floor'";
        format = "GPU  %output%W";
        interval = 2;
      };
    };
  };
}
