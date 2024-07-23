{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "intl";

      desktopManager.xterm.enable = false;
    };
  };
  # Import the graphical modules
  imports = [
    ./wayland-and-gnome
    # ./wayland-and-kyprland
    # ./wayland-and-sway
    # ./xserver-and-i3
  ];
}
