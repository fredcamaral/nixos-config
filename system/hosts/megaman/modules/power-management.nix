# system/modules/power-management.nix
{
  config,
  lib,
  ...
}: {
  # Enable Power Management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };
}
