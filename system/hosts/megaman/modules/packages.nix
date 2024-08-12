# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    supersonic-wayland
    rsync
    blueman
    todoist-electron
    amdgpu_top
    teams-for-linux
    zoom-us
    neovim
  ];
}
