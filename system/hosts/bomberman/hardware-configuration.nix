# system/hardware-configuration.nix
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  boot.initrd.availableKernelModules = ["uhci_hcd" "ahci" "xhci_pci" "nvme" "usbhid" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Root filesystem configuration
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS";
    fsType = "ext4";
  };

  # Home filesystem configuration
  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "ext4";
  };

  # Boot partition configuration
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  # No swap configuration (using zram or no swap)
  swapDevices = [{device = "/dev/disk/by-label/SWAP";}];

  # Set the system's architecture
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
