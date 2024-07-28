# system/modules/console.nix
{pkgs, ...}: {
  console = {
    # Set the console font
    # This uses the Terminus font, which is good for high-resolution displays
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";

    # Use the X keyboard configuration for the console as well
    useXkbConfig = true;
  };
}
