# system/modules/packages.nix
{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = [
    pkgs.rsync
    pkgs.blueman
    pkgs.todoist-electron
    pkgs.amdgpu_top
    pkgs.zoom-us
    pkgs.neovim
    pkgs.wayland
    pkgs.libinput
    pkgs.bzip3
    pkgs.bzip2
    pkgs-stable.google-chrome
  ];
}
