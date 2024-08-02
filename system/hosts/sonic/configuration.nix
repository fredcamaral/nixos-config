# configuration.nix
{
  inputs,
  pkgs,
  hostname,
  config,
  ...
}: {
  # Import all necessary configuration modules
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  boot = {
    loader.efi.efiSysMountPoint = "/boot";
    consoleLogLevel = 0;
    kernelParams = ["quiet" "udev.log_priority=3"];
  };

  systemd.services.getty = {
    serviceConfig.ExecStart = [
      ""
      "${pkgs.systemd}/lib/systemd/systemd-getty-generator %I"
    ];
  };

  ## ! CONFIG HERE: options for proprietary modules ##########################
  # Define the config for the module networking
  networking = {
    hostName = hostname;
    wireless = {
      enable = true;
      userControlled.enable = true;
      interfaces = ["wlp3s0"];
      networks = {
        "Fredflat_5G" = {
          psk = "FF1048654";
        };
        "Farenet" = {
          psk = config.age.secrets.sonic-wifi-farenet.path;
        };
      };
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
