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
    # "amdgpu.si_support=1" # Enable AMD C-State Coordination (C-State)
    # "amdgpu.cik_support=1" # Enable AMD C-State Coordination (C-State)
    # "amdgpu.ppfeaturemask=0xffffffff" # Enable all features for the amdgpu kernel module
    # "amdgpu.dcfeaturemask=0xffffffff" # Enable all features for the amdgpu kernel module
    # "intel_pstate=active" # Enable Intel P-State Coordination (C-State)
    # "amd_pstate=active" # Enable AMD P-State Coordination (C-State)
  ];

  # Kernel sysctl parameters
  boot.kernel.sysctl = {
    # "vm.vfs_cache_pressure" = 50; # Reduce inode/dentry cache pressure
    # "net.core.netdev_max_backlog" = 16384; # Increase network backlog
    # "net.ipv4.tcp_fastopen" = 3; # Enable TCP Fast Open
    # "net.ipv4.tcp_max_syn_backlog" = 8192; # Increase SYN backlog
    # "net.ipv4.tcp_max_tw_buckets" = 2000000; # Increase TIME_WAIT buckets
    # "net.ipv4.tcp_tw_reuse" = 1; # Enable TIME_WAIT reuse
    # "net.ipv4.tcp_fin_timeout" = 10; # Reduce FIN timeout
    # "net.core.somaxconn" = 1024; # Increase max queued connections
    # "net.ipv4.tcp_slow_start_after_idle" = 0; # Disable TCP slow start after idle
    # "net.core.rmem_max" = 16777216; # Increase max receive socket buffer size
    # "net.core.wmem_max" = 16777216; # Increase max send socket buffer size
  };

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
