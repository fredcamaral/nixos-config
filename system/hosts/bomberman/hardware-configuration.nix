# system/hardware-configuration.nix
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = with config.boot.kernelPackages; [];

  # # Kernel sysctl parameters
  # boot.kernel.sysctl = {
  #   "vm.vfs_cache_pressure" = 50; # Reduce inode/dentry cache pressure
  #   "net.core.netdev_max_backlog" = 16384; # Increase network backlog
  #   "net.ipv4.tcp_fastopen" = 3; # Enable TCP Fast Open
  #   "net.ipv4.tcp_max_syn_backlog" = 8192; # Increase SYN backlog
  #   "net.ipv4.tcp_max_tw_buckets" = 2000000; # Increase TIME_WAIT buckets
  #   "net.ipv4.tcp_tw_reuse" = 1; # Enable TIME_WAIT reuse
  #   "net.ipv4.tcp_fin_timeout" = 10; # Reduce FIN timeout
  #   "net.core.somaxconn" = 1024; # Increase max queued connections
  #   "net.ipv4.tcp_slow_start_after_idle" = 0; # Disable TCP slow start after idle
  #   "net.core.rmem_max" = 16777216; # Increase max receive socket buffer size
  #   "net.core.wmem_max" = 16777216; # Increase max send socket buffer size
  # };

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

  # Disable DHCP globally (we're using static IP configuration)
  networking.useDHCP = lib.mkDefault true;

  # Set the system's architecture
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
