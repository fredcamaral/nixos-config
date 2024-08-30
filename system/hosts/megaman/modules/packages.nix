# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    rsync
    blueman
    todoist-electron
    amdgpu_top
    zoom-us
    neovim
    wayland
    libinput
    bzip3
    bzip2
  ];
}
