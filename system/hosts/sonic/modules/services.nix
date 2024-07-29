# system/modules/services.nix
{
  pkgs,
  config,
  ...
}: {
  services = {
    # Enable OpenRGB for RGB lighting control
    hardware.openrgb.enable = false;

    # Add OpenRGB udev rules
    # udev.packages = with pkgs; [openrgb];

    # Enable periodic TRIM for SSDs
    fstrim.enable = true;

    # Enable OpenSSH server
    openssh.enable = true;

    # Enable CUPS for printing
    printing.enable = true;

    # Enable Tailscale VPN
    tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.sonic-tailscale-auth.path;
    };

    mpd = {
      enable = true;
      musicDirectory = "/media/limbo/music";
      startWhenNeeded = true;
    };

    # Configure PipeWire for audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable OllaMa for ROCm
    ollama = {
      enable = true;
      acceleration = "rocm";
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx1102"; # used to be necessary, but doesn't seem to anymore
      };
      rocmOverrideGfx = "11.0.0";
    };
  };
}
