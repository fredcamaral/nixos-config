# system/modules/virtualisation.nix
{
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    # Enable SPICE USB redirection
    spiceUSBRedirection.enable = true;

    # Enable Docker with rootless support
    docker = {
      enable = true;
      storageDriver = "overlay2";
      rootless.enable = true;
      autoPrune.enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      #
    ];
  };
}
