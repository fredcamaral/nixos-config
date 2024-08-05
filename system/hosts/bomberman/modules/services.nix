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
  };
}
