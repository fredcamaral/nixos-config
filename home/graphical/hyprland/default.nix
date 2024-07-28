# home.nix
{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      #
    ];

    systemd = {
      enable = true;
      variables = ["--all"];
      enableXdgAutostart = true;
    };
  };
}
