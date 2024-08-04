# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    iwd
    gpu-switch
    dmg2img
    python3
    tiny-dfr
  ];
}
