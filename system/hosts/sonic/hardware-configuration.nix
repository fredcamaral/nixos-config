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
  # boot.initrd.kernelModules = [""];

  # Kernel modules to load after boot
  boot.kernelModules = ["kvm-intel" "intel_pstate" "msr" "brcmfmac" "thunderbolt" "apple-bce" "apple-ib-tb"];

  # Any extra kernel packages to install
  # boot.extraModulePackages = [""];

  # boot.supportedFilesystems = [""];

  # Kernel parameters
  boot.kernelParams = [
    "intel_iommu=on" # Enable Intel IOMMU (for VT-d)
    "iommu=pt" # Enable IOMMU in pass-through mode
    "intel_pstate=active" # Enable Intel P-State Coordination (C-State)
    "brcmfmac.roamoff=1" # Disable brcmfmac WiFi power saving
    # "resume_offset=47329280" # Set resume offset
  ];

  # Kernel sysctl parameters
  boot.kernel.sysctl = {
    "vm.vfs_cache_pressure" = 50; # Reduce inode/dentry cache pressure
    "net.core.netdev_max_backlog" = 16384; # Increase network backlog
    "net.ipv4.tcp_fastopen" = 3; # Enable TCP Fast Open
    "net.ipv4.tcp_max_syn_backlog" = 8192; # Increase SYN backlog
    "net.ipv4.tcp_max_tw_buckets" = 2000000; # Increase TIME_WAIT buckets
    "net.ipv4.tcp_tw_reuse" = 1; # Enable TIME_WAIT reuse
    "net.ipv4.tcp_fin_timeout" = 10; # Reduce FIN timeout
    "net.core.somaxconn" = 1024; # Increase max queued connections
    "net.ipv4.tcp_slow_start_after_idle" = 0; # Disable TCP slow start after idle
    "net.core.rmem_max" = 16777216; # Increase max receive socket buffer size
    "net.core.wmem_max" = 16777216; # Increase max send socket buffer size
  };

  # Root filesystem configuration
  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/root";
    fsType = "ext4";
  };

  # Boot partition configuration
  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/EFI";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8192; # Size in MB, adjust as needed
    }
  ];

  boot.resumeDevice = "/var/lib/swapfile";

  # Disable DHCP globally (we're using static IP configuration)
  networking.useDHCP = lib.mkDefault true;

  # Set the system's architecture
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
