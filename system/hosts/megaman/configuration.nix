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

  systemd.services.home-backup = {
    description = "Backup home directory";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.rsync}/bin/rsync -avz --delete /home/fredamaral /media/ness/backup/home";
      User = "fredamaral";
    };
  };

  systemd.timers.home-backup = {
    wantedBy = ["timers.target"];
    partOf = ["home-backup.service"];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
  };

  ## ! CONFIG HERE: options for proprietary modules ##########################
  # Define the config for the module networking
  networking = {
    ${hostname} = {
      defaultGatewayAddress = "21.26.7.1";
      nameservers = ["8.8.8.8" "1.1.1.1"];

      primaryInterface = {
        name = "enp11s0";
        ipv4 = "21.26.7.2";
        dhcp = false;
      };

      # VPNed Interface
      secondaryInterface = {
        name = "enp10s0";
        ipv4 = "21.26.7.3";
        dhcp = false;
      };

      vpn = {
        enable = true;
        destinationPorts = "80,443,8080";
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
