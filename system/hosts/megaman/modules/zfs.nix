# system/modules/zfs.nix
{
  config,
  pkgs,
  ...
}: {
  boot = {
    # Use the latest Linux kernel compatible with ZFS
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

    # Enable ZFS support
    supportedFilesystems = ["zfs"];

    #zfs.extraPools = [
    #  "ness"
    #  "limbo"
    #];
  };

  services.zfs = {
    autoScrub.enable = true;
    autoScrub.interval = "weekly";

    autoSnapshot.enable = true;
    autoSnapshot.daily = 7;

    trim.enable = true;
    trim.interval = "weekly";
  };

  # Enable ZFS PAM module
  security.pam.zfs.enable = true;

  # Set the host ID for ZFS
  networking.hostId = "47d52338";
}
