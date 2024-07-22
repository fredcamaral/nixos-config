# home/default.nix
{pkgs, ...}: {
  # Import additional configuration files
  imports = [
    ./dconf.nix
  ];
  home = {
    # Install GNOME shell extensions
    packages = with pkgs.gnomeExtensions; [
      space-bar
      gtile
      focus-changer
      appindicator
      dim-background-windows
      taskwhisperer
      day-progress
      astra-monitor
    ];

    # Set default applications
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "micro";
      TERMINAL = "kitty";
    };
  };
}
