# configuration.nix
{
  inputs,
  hostname,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    useDHCP = true;
  };

  security.sudo.wheelNeedsPassword = false;

  graphical = {
    xdefaults.enable = true; # Enable X-Server defaults (true by default)
    managers = {
      enable = true; # Enable graphical environment (false by default)
      # gnome.enable = true;
      # hyprland.enable = true;
      # sway.enable = true;
      lightSway.enable = true;
      # i3.enable = true;
    };
  };

  # Specify the NixOS release version
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}
