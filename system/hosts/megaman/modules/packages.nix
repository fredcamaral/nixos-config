# system/modules/packages.nix
{
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
