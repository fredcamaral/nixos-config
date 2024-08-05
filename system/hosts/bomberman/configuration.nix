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

  graphical = {
    xdefaults.enable = false; # Enable X-Server defaults (true by default)
    managers = {
      enable = false; # Enable graphical environment (false by default)
    };
  };

  # Specify the NixOS release version
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}
