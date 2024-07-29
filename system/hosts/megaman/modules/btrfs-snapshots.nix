# btrfs-snapshots.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.btrbk]; # Add btrbk package to system packages

  environment.etc."btrbk/btrbk.conf".text = ''
    timestamp_format        long
    snapshot_preserve_min   1d
    snapshot_preserve       2d

    volume /home
      target /snapshots
  '';

  systemd.services.btrbk = {
    # Define a systemd service for btrbk
    description = "btrbk backup service"; # Set the service description
    wants = ["local-fs.target"]; # Declare that the service wants local filesystems
    after = ["local-fs.target"]; # Start the service after local filesystems are mounted
    path = [pkgs.btrbk]; # Add btrbk to the service's PATH
    serviceConfig = {
      Type = "oneshot"; # Set the service type to oneshot (run once and exit)
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /snapshots";
      ExecStart = "${pkgs.btrbk}/bin/btrbk run"; # Command to run when the service starts
    };
  };

  systemd.timers.btrbk = {
    # Define a systemd timer for btrbk
    wantedBy = ["timers.target"]; # Add the timer to the timers.target
    partOf = ["btrbk.service"]; # Associate the timer with the btrbk service
    timerConfig = {
      OnCalendar = "*-*-* 00/4:00:00"; # Run the service every 4 hours
      Persistent = true; # If the system was off, run on next boot
    };
  };
}
