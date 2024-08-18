{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./i3
  ];

  nixpkgs.config.permittedInsecurePackages = [
    # Needed for k2pdfopt 2.53.
    "mupdf-1.17.0"
  ];
  # boot.loader.systemd-boot.consoleMode = "0";

  services.xserver.enable = true;
}
