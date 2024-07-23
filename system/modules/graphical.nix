{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "intl";
    };
  };

  # Import the graphical modules
  imports = map (graphical: ./graphical/${graphical}.nix) [
    "gnome"
    # "i3"
  ];
}
