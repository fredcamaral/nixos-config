# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    wpa_supplicant
    wpa_supplicant_gui
  ];
}
