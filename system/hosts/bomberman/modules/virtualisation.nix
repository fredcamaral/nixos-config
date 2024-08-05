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

  boot.binfmt.emulatedSystems = ["x86_64-linux"];
  disabledModules = ["virtualisation/vmware-guest.nix"];
  networking.interfaces.ens160.useDHCP = true;
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
    storageDriver = "overlay2";
    rootless.enable = true;
    autoPrune.enable = true;
  };
}
