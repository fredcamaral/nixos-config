# system/modules/virtualisation.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    vmware/vmware-guest.nix
  ];

  # custom module for vmware on ./vmware
  disabledModules = ["virtualisation/vmware-guest.nix"];
  virtualisation.vmware.guest.enable = true;

  # Share our host filesystem
  fileSystems."/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:/";
    options = [
      "umask=22"
      "uid=1000"
      "gid=1000"
      "allow_other"
      "auto_unmount"
      "defaults"
    ];
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };
}
