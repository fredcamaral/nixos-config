{...}: {
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # security.ssh = {
  #   permitRootLogin = "no";
  #   passwordAuthentication = true;
  #   allowUsers = ["fredamaral"];
  # };

  security.lockKernelModules = true;
  # security.timesyncd.enable = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = "https://nixos.org/channels/nixos-unstable";
  };
}
