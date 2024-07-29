# configuration.nix
{
  inputs,
  hostname,
  ...
}: {
  # Import all necessary configuration modules
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  ## ! CONFIG HERE: options for proprietary modules ##########################
  # Define the config for the module networking
  networking = {
    hostName = hostname;
    wireless = {
      enable = true;
      userControlled.enable = true;
      interfaces = ["wlp3s0"];
    };
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
    };
  };
  ## ! END CONFIG #############################################################

  # Specify the NixOS release version
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}
