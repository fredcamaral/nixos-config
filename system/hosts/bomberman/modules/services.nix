# system/modules/services.nix
{
  pkgs,
  config,
  ...
}: {
  services = {
    openssh.enable = true;
    tailscale = {
      enable = true;
      # authKeyFile = config.age.secrets.bomberman-tailscale-auth.path;
    };

    # Enable CUPS to print documents
    printing.enable = true;
  };

  # Enable touchpad support
  services.xserver.libinput.enable = true;
}
