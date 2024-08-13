# This is based on the official vmware-guest module, but modified
# for aarch64 to disable certain features and add support. I'm unsure
# how to upstream this because I just don't use certain features... maybe
# making them toggle-able? I'm not sure.
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.virtualisation.vmware.guest;
  open-vm-tools =
    if cfg.headless
    then pkgs.open-vm-tools-headless
    else pkgs.open-vm-tools;
  xf86inputvmmouse = pkgs.xorg.xf86inputvmmouse;
in {
  imports = [
    (mkRenamedOptionModule ["services" "vmwareGuest"] ["virtualisation" "vmware" "guest"])
  ];

  options.virtualisation.vmware.guest = {
    enable = mkEnableOption "VMWare Guest Support";
    headless = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to disable X11-related features.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.isi686 || pkgs.stdenv.isx86_64 || pkgs.stdenv.isAarch64;
        message = "VMWare guest is not currently supported on ${pkgs.stdenv.hostPlatform.system}";
      }
    ];

    # The `mptspi` kernel module is loaded in the initrd to provide support for the
    # SCSI controller used by VMware. This is necessary for the virtual machine to
    # be able to access its virtual disks.
    #
    # The `vmw_pvscsi` kernel module is commented out, as it may not be necessary
    # for all VMware guest configurations. It provides support for the VMware
    # paravirtual SCSI controller, which can improve disk performance in some
    # cases.
    boot.initrd.availableKernelModules = ["mptspi"];
    # boot.initrd.kernelModules = [ "vmw_pvscsi" ];

    # The `open-vm-tools` package provides a set of utilities for VMware virtual machines, including tools for managing the virtual machine,
    # sharing files between the host and guest, and more. This package is required for the VMware guest support functionality provided by this module.
    environment.systemPackages = [open-vm-tools];

    systemd.services.vmware = {
      description = "VMWare Guest Service";
      wantedBy = ["multi-user.target"];
      after = ["display-manager.service"];
      unitConfig.ConditionVirtualization = "vmware";
      serviceConfig.ExecStart = "${open-vm-tools}/bin/vmtoolsd";
    };

    # Mount the vmblock for drag-and-drop and copy-and-paste.
    systemd.mounts = [
      {
        description = "VMware vmblock fuse mount";
        documentation = ["https://github.com/vmware/open-vm-tools/blob/master/open-vm-tools/vmblock-fuse/design.txt"];
        unitConfig.ConditionVirtualization = "vmware";
        what = "${open-vm-tools}/bin/vmware-vmblock-fuse";
        where = "/run/vmblock-fuse";
        type = "fuse";
        options = "subtype=vmware-vmblock,default_permissions,allow_other";
        wantedBy = ["multi-user.target"];
      }
    ];

    security.wrappers.vmware-user-suid-wrapper = {
      setuid = true;
      owner = "root";
      group = "root";
      source = "${open-vm-tools}/bin/vmware-user-suid-wrapper";
    };

    environment.etc.vmware-tools.source = "${open-vm-tools}/etc/vmware-tools/*";

    services.xserver = mkIf (!cfg.headless) {
      # TODO: does not build on aarch64
      # modules = [ xf86inputvmmouse ];

      config = ''
        Section "InputClass"
          Identifier "VMMouse"
          MatchDevicePath "/dev/input/event*"
          MatchProduct "ImPS/2 Generic Wheel Mouse"
          Driver "vmmouse"
        EndSection
      '';

      displayManager.sessionCommands = ''
        ${open-vm-tools}/bin/vmware-user-suid-wrapper
      '';
    };

    # Installs the open-vm-tools package, which provides utilities for VMware guests. This ensures the necessary VMware guest utilities are available on the system.
    services.udev.packages = [open-vm-tools];
  };
}
