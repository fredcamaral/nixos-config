# home/default.nix
{pkgs, ...}: {
  # Import additional configuration files
  imports = [
    ./gnome/dconf.nix
  ];
  programs = {
    gnome-shell.extensions = {
      enable = true;
      packages = with pkgs.gnomeExtensions; [
        space-bar
        gtile
        focus-changer
        appindicator
        dim-background-windows
        day-progress
        astra-monitor
        smart-auto-move
      ];
    };
  };
}
