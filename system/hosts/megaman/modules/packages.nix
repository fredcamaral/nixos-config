# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    supersonic-wayland
    rsync
    blueman
    todoist-electron # To-do list manager
    amdgpu_top # AMD GPU utilization monitor
    teams-for-linux # Microsoft Teams client for Linux
    zoom-us # Video conferencing and online meeting platform
  ];
}
