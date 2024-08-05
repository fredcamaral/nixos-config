# system/modules/console.nix
{pkgs, ...}: {
  console = {
    # This uses the Terminus font, which is good for high-resolution displays
    font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/DejaVuSansMono Nerd Font Complete Mono.ttf";

    # Use the X keyboard configuration for the console as well
    useXkbConfig = true;
  };
}
