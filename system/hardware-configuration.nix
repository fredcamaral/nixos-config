# system/hardware-configuration.nix
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Kernel modules to load during boot
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod"];

  # Additional kernel modules to load during boot
  boot.initrd.kernelModules = ["amdgpu"];

  # Kernel modules to load after boot
  boot.kernelModules = ["kvm-intel"];

  # Any extra kernel packages to install
  boot.extraModulePackages = [];

  # Kernel parameters
  boot.kernelParams = [
    "intel_iommu=on" # Enable Intel IOMMU (for VT-d)
    "iommu=pt" # Enable IOMMU in pass-through mode
  ];

  # Root filesystem configuration
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b2edd2b8-d7ca-4dfe-afc0-1a38271f1ea9";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  # Boot partition configuration
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B457-F535";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  # No swap configuration (using zram or no swap)
  swapDevices = [];

  # Additional filesystems
  fileSystems."/media/bridge" = {
    device = "/dev/disk/by-uuid/6dbcbab3-b31d-4c6c-a830-c24b06ad290e";
    fsType = "ext4";
  };

  fileSystems."/media/vms" = {
    device = "/dev/disk/by-uuid/78157258-2094-4ddd-b3f4-e72df1529000";
    fsType = "ext4";
  };

  # Disable DHCP globally (we're using static IP configuration)
  networking.useDHCP = lib.mkDefault false;

  # Set the system's architecture
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Enable CPU microcode updates if the system supports it
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
