# system/modules/hardware.nix
{
  pkgs,
  lib,
  ...
}: {
  hardware = {
    # Enable Bluetooth support
    bluetooth.enable = true;

    # Disable PulseAudio (likely using PipeWire instead)
    pulseaudio.enable = false;

    # CPU configuration
    cpu.intel.updateMicrocode = true;

    # GPU configuration
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
    amdgpu.initrd.enable = true;
    amdgpu.opencl.enable = true;

    # Firmware configuration
    enableRedistributableFirmware = true;

    graphics = {
      # Enable graphics support
      enable = true;

      # Enable 32-bit graphics libraries
      enable32Bit = true;

      # Add extra graphics packages (AMD specific)
      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr
        rocmPackages.rpp
        rocmPackages.rccl
        rocmPackages.half
      ];

      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };

  # Power management
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
