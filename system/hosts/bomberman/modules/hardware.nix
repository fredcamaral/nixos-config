# system/modules/hardware.nix
{
  pkgs,
  config,
  lib,
  ...
}: {
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };
  hardware.pulseaudio.enable = true;
}
