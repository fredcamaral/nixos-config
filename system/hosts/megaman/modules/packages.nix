# system/modules/packages.nix
{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = [
    pkgs.blueman
    pkgs.todoist-electron
    pkgs.zoom-us
    pkgs.neovim
    pkgs.bzip3
    pkgs.bzip2
    pkgs.google-chrome
  ];
}
