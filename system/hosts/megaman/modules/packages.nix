# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    supersonic-wayland
    rsync
    thunderbird
    blueman
    todoist-electron # To-do list manager
    amdgpu_top # AMD GPU utilization monitor
  ];
}
