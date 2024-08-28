{
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    layer = "top";
    width = 300;
    height = 100;
    borderSize = 2;
    borderRadius = 5;
  };

  wayland.windowManager.hyprland.extraConfig = ''
    # Ensure mako starts with Hyprland
    exec-once = mako
  '';
}
