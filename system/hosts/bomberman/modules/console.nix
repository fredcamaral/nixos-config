# system/modules/console.nix
{pkgs, ...}: {
  console = {
    # This uses the Terminus font, which is good for high-resolution displays
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-v22n.psf.gz";

    # Use the X keyboard configuration for the console as well
    useXkbConfig = true;
  };
}
