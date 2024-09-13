# system/modules/virtualisation.nix
{
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";

      # Configure QEMU
      qemu = {
        package = pkgs.qemu_full;
        runAsRoot = false;

        # Enable OVMF for UEFI support in virtual machines
        ovmf.enable = true;
        ovmf.packages =
          if pkgs.stdenv.isx86_64
          then [pkgs.OVMFFull.fd]
          else [pkgs.OVMF.fd];

        # Enable VirtIO-FS for better shared folder performance
        verbatimConfig = ''
          user = "${config.users.users.fredamaral.name}"
          group = "kvm"
          cgroup_device_acl = [
              "/dev/null", "/dev/full", "/dev/zero",
              "/dev/random", "/dev/urandom",
              "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
              "/dev/rtc","/dev/hpet"
          ]
        '';
      };
    };

    # Enable SPICE USB redirection
    spiceUSBRedirection.enable = true;

    # Enable Docker with rootless support
    docker = {
      enable = true;
      rootless.enable = true;
      autoPrune.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    virglrenderer # For 3D acceleration in VMs
    qemu # Machine emulator and virtualizer
    spice # Remote computing solution
    spice-gtk # GTK client and libraries for SPICE remote desktop servers
    spice-protocol # SPICE protocol headers
    virt-manager # Desktop user interface for managing virtual machines
    virt-viewer # Graphical viewer for the guest OS display
    win-spice # Windows guest agent for SPICE protocol
    win-virtio # Windows guest drivers for QEMU virtual machines
    OVMF # UEFI firmware for QEMU
  ];
}
