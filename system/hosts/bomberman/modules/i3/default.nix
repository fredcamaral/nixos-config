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
    gnome.gnome-keyring.enable = true;

    xserver.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = ./i3.config;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
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
