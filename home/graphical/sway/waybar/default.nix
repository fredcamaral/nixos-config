{
  lib,
  config,
  pkgs,
  ...
}: let
  waybarCustomStyle = builtins.readFile ./waybar-style.css;

  getWaybarStyle = config:
    if !config.stylix.targets.waybar.enable
    then waybarCustomStyle
    else "";

  commonModules = {
    "sway/workspaces" = {
      format = "{icon} {name}";
      all-outputs = false;
      show-special = true;
      format-icons = {
        "1" = "󰣇";
        "2" = "󰅨";
        "3" = "󰅨";
        "4" = "󰍡";
        "5" = "󱁿";
        "6" = "󰝚";
        "7" = "󰀒";
        "8" = "󰆍";
        "9" = "󱉟";
        "10" = "󰐗";
      };
    };

    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };

    "sway/window" = {
      format = "󰖯 {}";
      max-length = 100;
    };

    battery = {
      format = "{capacity}% {icon}";
      format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      format-charging = "{capacity}% 󰂄";
      interval = 30;
      states = {
        warning = 30;
        critical = 15;
      };
    };

    "custom/cpu-label" = {
      exec = "${pkgs.coreutils}/bin/echo 'CPU:'";
      format = "{}";
      interval = "once";
    };

    cpu = {
      format = "󰻠 {usage}%";
      tooltip = false;
      interval = 1;
    };

    "custom/temperature" = {
      exec = "${pkgs.lm_sensors}/bin/sensors -j coretemp-isa-0000 | ${pkgs.jq}/bin/jq '.[\"coretemp-isa-0000\"][\"Package id 0\"].temp1_input | floor'";
      format = "󰔏 {}°C";
      interval = 1;
    };

    "custom/mem-label" = {
      exec = "${pkgs.coreutils}/bin/echo '     MEM:'";
      format = "{}";
      interval = "once";
    };

    memory = {
      format = "󰍛 {used:0.1f}G/{total:0.1f}G";
      interval = 1;
      tooltip = false;
    };

    "custom/gpu-label" = {
      exec = "${pkgs.coreutils}/bin/echo '     GPU:'";
      format = "{}";
      interval = "once";
    };

    "custom/gpu-power-usage" = {
      exec = "${pkgs.lm_sensors}/bin/sensors -j amdgpu-pci-0300 | ${pkgs.jq}/bin/jq '.\"amdgpu-pci-0300\".PPT.power1_average | floor'";
      format = "󱐋 {}W  ";
      interval = 1;
    };

    "custom/gpu-temperature" = {
      exec = "${pkgs.lm_sensors}/bin/sensors -j amdgpu-pci-0300 | ${pkgs.jq}/bin/jq '.\"amdgpu-pci-0300\".edge.temp1_input | floor'";
      format = "󰢮 {}°C  ";
      interval = 1;
    };

    "custom/gpu-mem-temperature" = {
      exec = "${pkgs.lm_sensors}/bin/sensors -j amdgpu-pci-0300 | ${pkgs.jq}/bin/jq '.\"amdgpu-pci-0300\".mem.temp3_input | floor'";
      format = "󰍛 {}°C";
      interval = 1;
    };

    "network#nic1" = {
      interface = "enp11s0";
      format-ethernet = "󰈀 {ipaddr} 󰕒 {bandwidthUpBytes} 󰇚 {bandwidthDownBytes}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "Disconnected ⚠";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      interval = 1;
      min-length = 30;
    };

    "network#nic2" = {
      interface = "enp10s0";
      format-ethernet = "󰈀 {ipaddr} 󰕒 {bandwidthUpBytes} 󰇚 {bandwidthDownBytes}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "Disconnected ⚠";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      interval = 1;
      min-length = 30;
    };

    "network#nic3" = {
      interface = "enp7s0u1";
      format-ethernet = "󰈀 Wired ({ipaddr}): 󰕒 {bandwidthUpBytes} 󰇚 {bandwidthDownBytes}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "Wired ⚠";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      interval = 1;
    };

    "network#nic4" = {
      interface = "wlp3s0";
      format-wifi = "󰈀 WiFi ({ipaddr}): 󰕒 {bandwidthUpBytes} 󰇚 {bandwidthDownBytes}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "WiFi ⚠";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      interval = 1;
    };

    tray = {
      icon-size = 12;
      spacing = 10;
    };

    "custom/audio-label" = {
      exec = "${pkgs.coreutils}/bin/echo '     Audio:'";
      format = "{}";
      interval = "once";
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-bluetooth = "{volume}% {icon}";
      format-bluetooth-muted = "󰂲 {icon}";
      format-muted = "󰝟";
      format-icons = {
        headphone = "󰋋";
        hands-free = "󰥰";
        headset = "󰋎";
        phone = "󰏲";
        portable = "󰏲";
        car = "󰄋";
        default = ["󰕿" "󰖀" "󰕾"];
      };
      on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1% && pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk '{print $5}' | sed 's/[%\\n]//g' | xargs -I{} sh -c 'if [ {} -gt 100 ]; then pactl set-sink-volume @DEFAULT_SINK@ 100%; fi'";
      on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
      max-volume = 100;
      tooltip = false;
    };

    "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = "󰍬 {volume}%";
      format-source-muted = "󰍭";
      on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
      on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +1% && pactl get-source-volume @DEFAULT_SOURCE@ | head -n 1 | awk '{print $5}' | sed 's/[%\\n]//g' | xargs -I{} sh -c 'if [ {} -gt 100 ]; then pactl set-source-volume @DEFAULT_SOURCE@ 100%; fi'";
      on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -1%";
      max-volume = 100;
      tooltip = false;
    };

    clock = {
      format = "󰅐 {:%B %d, %A - %H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };

    "clock#laptop" = {
      format = "󰅐 {%H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };

    "custom/user-host-label" = {
      exec = "${pkgs.coreutils}/bin/echo \"    $(${pkgs.coreutils}/bin/whoami)@$(${pkgs.hostname}/bin/hostname)\"";
      format = "{}";
      interval = "once";
    };
  };
in {
  programs.waybar = {
    enable = true;
    settings = [
      {
        output = "DP-1";
        layer = "top";
        position = "top";
        height = 36;
        spacing = 4;
        icon_theme = "Vimix-White";
        modules-left = [
          "tray"
          "sway/workspaces"
          "sway/mode"
          "network#nic1"
          "network#nic2"
        ];
        modules-center = ["sway/window"];
        modules-right = [
          "custom/cpu-label"
          "cpu"
          "custom/temperature"
          "custom/mem-label"
          "memory"
          "custom/gpu-label"
          "custom/gpu-power-usage"
          "custom/gpu-temperature"
          "custom/gpu-mem-temperature"
          "custom/audio-label"
          "pulseaudio"
          "pulseaudio#microphone"
          "custom/user-host-label"
          "clock"
          "idle_inhibitor"
        ];
        inherit
          (commonModules)
          "sway/workspaces"
          "sway/window"
          "network#nic1"
          "network#nic2"
          "custom/cpu-label"
          "cpu"
          "custom/temperature"
          "memory"
          "custom/mem-label"
          "custom/gpu-label"
          "custom/gpu-power-usage"
          "custom/gpu-temperature"
          "custom/gpu-mem-temperature"
          "custom/audio-label"
          "pulseaudio"
          "pulseaudio#microphone"
          "tray"
          "custom/user-host-label"
          "clock"
          "idle_inhibitor"
          ;
      }
      {
        output = "DP-2";
        layer = "top";
        position = "top";
        height = 36;
        spacing = 4;
        icon_theme = "Vimix-White";
        modules-left = ["sway/workspaces" "sway/mode"];
        modules-center = ["sway/window"];
        modules-right = [
          "custom/user-host-label"
          "clock"
          "idle_inhibitor"
        ];
        inherit
          (commonModules)
          "sway/workspaces"
          "sway/window"
          "custom/user-host-label"
          "clock"
          "idle_inhibitor"
          ;
      }
      {
        output = "DP-3";
        layer = "top";
        position = "top";
        height = 36;
        spacing = 4;
        icon_theme = "Vimix-White";
        modules-left = ["sway/workspaces" "sway/mode"];
        modules-center = ["sway/window"];
        modules-right = [
          "custom/user-host-label"
          "clock"
          "idle_inhibitor"
        ];
        inherit
          (commonModules)
          "sway/workspaces"
          "sway/window"
          "custom/user-host-label"
          "clock"
          "idle_inhibitor"
          ;
      }
      {
        output = "eDP-1";
        layer = "top";
        position = "top";
        height = 36;
        spacing = 4;
        icon_theme = "Vimix-White";
        modules-left = [
          "tray"
          "sway/workspaces"
          "sway/mode"
          "network#nic3"
          "network#nic4"
        ];
        modules-center = ["sway/window"];
        modules-right = [
          "cpu"
          "custom/temperature"
          "memory"
          "pulseaudio"
          "pulseaudio#microphone"
          "battery"
          "clock"
          "idle_inhibitor"
        ];
        inherit
          (commonModules)
          "sway/workspaces"
          "sway/window"
          "network#nic3"
          "network#nic4"
          "battery"
          "cpu"
          "custom/temperature"
          "memory"
          "custom/gpu-power-usage"
          "custom/gpu-temperature"
          "custom/gpu-mem-temperature"
          "pulseaudio"
          "pulseaudio#microphone"
          "tray"
          "clock#laptop"
          "idle_inhibitor"
          ;
      }
    ];

    style = getWaybarStyle config;
  };
}
