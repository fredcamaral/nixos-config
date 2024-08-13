# home/stylix.nix
{pkgs, ...}: {
  stylix = {
    # Disable for...
    targets = {
      waybar.enable = true;
    };
  };
}
