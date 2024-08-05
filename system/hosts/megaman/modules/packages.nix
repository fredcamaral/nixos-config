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
    slack # Team communication and collaboration software
    teams-for-linux # Microsoft Teams client for Linux
    telegram-desktop # Fast and secure messaging app
    whatsapp-for-linux # WhatsApp client for Linux
    zoom-us # Video conferencing and online meeting platform
  ];
}
