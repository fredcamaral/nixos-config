{
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    layer = "top";
    width = 300;
    height = 100;
    borderSize = 2;
    borderRadius = 5;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    progressColor = "over #313244";
    extraConfig = ''
      [urgency=high]
      border-color=#fab387
    '';
  };

  wayland.windowManager.hyprland.extraConfig = ''
    # Ensure mako starts with Hyprland
    exec-once = mako
  '';
}
