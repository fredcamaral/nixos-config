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

    # Enable CPU microcode updates if the system supports it
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # Enable all firmware updates
    enableAllFirmware = true;

    # Enable Apple's Boot Set OS Loader firmware
    apple-t2.enableAppleSetOsLoader = true;

    # Firmware configuration
    enableRedistributableFirmware = true;

    graphics = {
      # Enable graphics support
      enable = true;

      # Enable 32-bit graphics libraries
      enable32Bit = true;

      # Add extra graphics packages (AMD specific)
      extraPackages = with pkgs; [
        #
      ];

      extraPackages32 = with pkgs; [
        #
      ];
    };
  };
}
