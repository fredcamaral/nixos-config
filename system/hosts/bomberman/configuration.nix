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

  # systemd.services.home-backup = {
  #   description = "Backup home directory";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = ''
  #       ${pkgs.rsync}/bin/rsync -avz --delete /home/fredamaral /media/ness/backup/home
  #     '';
  #     User = "fredamaral";
  #   };
  # };

  # systemd.timers.home-backup = {
  #   wantedBy = ["timers.target"];
  #   partOf = ["home-backup.service"];
  #   timerConfig = {
  #     OnCalendar = "hourly";
  #     Persistent = true;
  #   };
  # };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  # Graphical environment configuration
  graphical = {
    xdefaults.enable = false; # Enable X-Server defaults (true by default)
    managers = {
      enable = false; # Enable graphical environment (false by default)
      # gnome.enable = true;
      # hyprland.enable = true;
      # sway.enable = true;
      # i3.enable = true;
    };
  };

  # Specify the NixOS release version
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}
