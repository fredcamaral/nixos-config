# system/modules/hardware.nix
{
  pkgs,
  config,
  lib,
  ...
}: {
  hardware = {
    # Enable Bluetooth support
    bluetooth.enable = true;

    # Disable PulseAudio (likely using PipeWire instead)
    pulseaudio.enable = false;

    # Enable all firmware updates
    enableAllFirmware = true;

    # Firmware configuration
    enableRedistributableFirmware = true;

    graphics = {
      # Enable graphics support
      enable = true;

      # Add extra graphics packages (AMD specific)
      extraPackages = with pkgs; [
      ];

      extraPackages32 = with pkgs; [
      ];
    };
  };
}
