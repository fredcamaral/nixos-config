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
    useDHCP = false;
  };

  security.sudo.wheelNeedsPassword = false;

  # Specify the NixOS release version
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}
