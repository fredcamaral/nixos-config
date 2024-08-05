# system/modules/nixsettings.nix
{config, ...}: {
  # Enable the ROCm support
  nixpkgs.config.rocmSupport = true;
}
