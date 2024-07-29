# configuration.nix
{inputs, ...}: {
  # Import all necessary configuration modules
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  ## ! CONFIG HERE: options for proprietary modules ##########################
  # Define the config for the module networking
  networking = {
    hostName = "sonic";
    # vpnConfig = {
    #   enable = true;
    #   defaultGatewayAddress = "21.26.7.1";
    #   nameservers = ["8.8.8.8" "1.1.1.1"];
    #   networkPrefix = "21.26.7";
    #   freeFlowInterface = "enp11s0";
    #   vpnedInterface = "enp10s0";
    #   vpnedPorts = "80,443,8080";
    # };
  };

  # Graphical environment configuration
  graphical = {
    xdefaults.enable = true; # Enable X-Server defaults (true by default)
    managers = {
      enable = true; # Enable graphical environment (false by default)

      # Choose one of the following (or none for default GNOME):
      # gnome.enable = true;
      # hyprland.enable = true;
      sway.enable = true;
      # i3.enable = true;
      # river.enable = true;
    };
  };
  ## ! END CONFIG #############################################################

  # Specify the NixOS release version
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}
