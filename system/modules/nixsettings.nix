# system/modules/nixsettings.nix
{config, ...}: {
  # Disable the NixOS manual in the system
  documentation.nixos.enable = false;

  # Allow unfree packages to be installed
  nixpkgs.config.allowUnfree = true;

  # Enable the ROCm support
  nixpkgs.config.rocmSupport = true;

  nix.settings = {
    # Disable warning about dirty git tree
    warn-dirty = false;

    # Enable experimental features: nix command and flakes
    experimental-features = "nix-command flakes";
  };

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  # Garbage Collection
  # nix.gc = {
  #   automatic = true;
  #   interval.Day = 7;
  #   options = "--delete-older-than 7d";
  # };
}
