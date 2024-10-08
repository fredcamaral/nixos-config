# system/modules/nixsettings.nix
{config, ...}: {
  # Enable the ROCm support
  nixpkgs.config = {
    rocmSupport = true;
    permittedInsecurePackages = [
      "olm-3.2.16"
      "electron-29.4.6"
    ];
  };
}
