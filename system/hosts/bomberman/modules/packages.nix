# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    supersonic-wayland
    rsync
    thunderbird
    blueman
    alacritty
  ];
}
