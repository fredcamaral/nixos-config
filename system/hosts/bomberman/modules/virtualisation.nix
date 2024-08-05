# system/modules/virtualisation.nix
{
  config,
  pkgs,
  ...
}: {
  # Enable Docker with rootless support
  docker = {
    enable = true;
    storageDriver = "overlay2";
    rootless.enable = true;
    autoPrune.enable = true;
  };
}
