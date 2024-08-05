# configuration.nix
{
  inputs,
  hostname,
  pkgs,
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
      ExecStart = ''
        ${pkgs.rsync}/bin/rsync -avz --delete /home/fredamaral /media/ness/backup/home
      '';
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
    hostName = hostname;
    networkmanager.enable = true;
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
