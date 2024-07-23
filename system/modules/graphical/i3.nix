{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "intl";

      displayManager.sddm = {
        enable = true;
      };
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };
}
