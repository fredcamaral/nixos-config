{
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.permittedInsecurePackages = [
    # Needed for k2pdfopt 2.53.
    "mupdf-1.17.0"
  ];
  # boot.loader.systemd-boot.consoleMode = "0";

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    dpi = 220;

    desktopManager = {
      xterm.enable = false;
      # wallpaper.mode = "fill";
    };

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;

      sessionCommands = ''
      '';
    };

    imports = [
      ./i3
    ];
  };
}
