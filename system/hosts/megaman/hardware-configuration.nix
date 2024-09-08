# system/hardware-configuration.nix
{
  config,
  lib,
  ...
}: {
  # Kernel modules to load during boot
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod"];

  # Additional kernel modules to load during boot
  boot.initrd.kernelModules = ["amdgpu"];

  # Kernel modules to load after boot
  boot.kernelModules = ["kvm-intel" "intel_pstate" "msr"];

  # Any extra kernel packages to install
  boot.extraModulePackages = [];

  # Kernel parameters
  boot.kernelParams = [
    "intel_iommu=on" # Enable Intel IOMMU (for VT-d)
    "amd_iommu=on" # Enable AMD IOMMU (for AMD-Vi)
    "iommu=pt" # Enable IOMMU in pass-through mode
  ];

  # Root filesystem configuration
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  # Home filesystem configuration
  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "btrfs";
  };

  # Boot partition configuration
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  # No swap configuration (using zram or no swap)
  swapDevices = [];

  # Additional filesystems
  fileSystems."/media/bridge" = {
    device = "/dev/disk/by-label/bridge";
    fsType = "ext4";
  };

  fileSystems."/media/vms" = {
    device = "/dev/disk/by-label/vms";
    fsType = "ext4";
  };

  # Set the system's architecture
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
