# configuration.nix
{
  inputs,
  hostname,
  pkgs,
  ...
}: {
  # Import all necessary configuration modules
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = "24.05";
}
