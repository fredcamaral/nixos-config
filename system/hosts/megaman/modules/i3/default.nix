{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  # Enable some XFCE-related services
  services.upower.enable = true; # Power management
  services.accounts-daemon.enable = true; # User accounts
  services.gvfs.enable = true; # File sharing
  services.tumbler.enable = true; # Screenshots
}
