{pkgs, ...}: let
  user = "fredamaral";
in {
  users = {
    defaultUserShell = pkgs.zsh;

    users.${user} = {
      isNormalUser = true;
      home = "/home/${user}";
      createHome = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "qemu"
        "kvm"
        "qemu-libvirtd"
        "libvirtd"
        "networkmanager"
        "docker"
        "plugdev"
      ];
    };
  };
}
