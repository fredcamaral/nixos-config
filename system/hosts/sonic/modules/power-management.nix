# system/modules/power-management.nix
{
  config,
  lib,
  ...
}: {
  # Enable Power Management
  powerManagement = {
    enable = true;
    # cpuFreqGovernor = lib.mkDefault "conservative";
  };

  services.mbpfan = {
    enable = true;
    settings.general = {
      low_temp = 60;
      high_temp = 70;
      max_temp = 90;
    };
  };
}
