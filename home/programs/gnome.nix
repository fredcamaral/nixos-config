# home/default.nix
{...}: {
  # Import additional configuration files
  imports = [
    ./gnome/dconf.nix
  ];
}
