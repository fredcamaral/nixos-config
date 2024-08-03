# home/programs.nix
{
  pkgs,
  lib,
  ...
}: {
  programs = {
    streamdeck-ui = {
      enable = true;
      autoStart = true;
    };
  };
}
