# system/modules/services.nix
{
  pkgs,
  config,
  ...
}: {
  services = {
    # Enable periodic TRIM for SSDs
    fstrim.enable = true;

    # Enable OpenSSH server
    openssh.enable = true;

    # Enable CUPS for printing
    printing.enable = true;

    # Enable Tailscale VPN
    tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.bomberman-tailscale-auth.path;
    };

    # Configure PipeWire for audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
