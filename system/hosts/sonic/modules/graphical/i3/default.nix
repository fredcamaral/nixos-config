{pkgs, ...}: {
  services = {
    displayManager.sddm = {
      enable = true;
    };
    xserver = {
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
    # Enable GNOME Keyring
    gnome.gnome-keyring.enable = true;
  };
}
