# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    wpa_supplicant
    wpa_supplicant_gui
    gpu-switch
    dmg2img
    python3
  ];
}
