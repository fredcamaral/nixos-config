# system/modules/boot.nix
{
  config,
  pkgs,
  ...
}: {
  boot.loader = {
    # Enable the systemd-boot EFI boot loader
    systemd-boot.enable = true;

    # Allow editing the kernel command line on boot
    systemd-boot.editor = true;

    # Limit the number of generations kept to 10
    systemd-boot.configurationLimit = 10;

    # Allow modification of EFI boot variables
    efi.canTouchEfiVariables = true;
  };

  # Enable systemd in the initial ramdisk
  boot.initrd.systemd.enable = true;

  # Use the latest kernel version
  # boot.kernelPackages = pkgs.linuxPackages_latest;
}
