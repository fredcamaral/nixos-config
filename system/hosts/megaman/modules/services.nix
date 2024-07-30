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
      authKeyFile = config.age.secrets.megaman-tailscale-auth.path;
    };

    navidrome = {
      enable = true;
      openFirewall = true;
      settings = {
        Port = 4533;
        MusicFolder = "/media/limbo/music";
        DataFolder = "/media/limbo/navidrome/data";
        CacheFolder = "/media/limbo/navidrome/cache";
      };
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
