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

    memory = {
      format = "󰍛 {used:0.1f}G/{total:0.1f}G";
      interval = 1;
      tooltip = false;
    };

    "network#bomberman" = {
      interface = "enp2s0";
      format-ethernet = "󰈀 ({ipaddr}): 󰕒 {bandwidthUpBytes} 󰇚 {bandwidthDownBytes}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "Network Disconnected ⚠";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      interval = 1;
    };

    tray = {
      icon-size = 12;
      spacing = 10;
    };

    "clock#bomberman" = {
      format = "󰅐 {%H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
  };
in {
  programs.waybar = {
    enable = true;
    settings = [
      {
        output = "Virtual-1";
        layer = "top";
        position = "top";
        height = 36;
        spacing = 4;
        icon_theme = "Vimix-White";
        modules-left = [
          "tray"
          "sway/workspaces"
          "sway/mode"
          "network#bomberman"
        ];
        modules-center = ["sway/window"];
        modules-right = [
          "cpu"
          "custom/temperature"
          "memory"
          "battery"
          "clock"
          "idle_inhibitor"
        ];
        inherit
          (commonModules)
          "sway/workspaces"
          "sway/window"
          "network#bomberman"
          "battery"
          "cpu"
          "custom/temperature"
          "memory"
          "tray"
          "clock#bomberman"
          "idle_inhibitor"
          ;
      }
    ];

    style = getWaybarStyle config;
  };
}
