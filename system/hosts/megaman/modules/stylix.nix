# system/modules/stylix.nix
{pkgs, ...}: {
  stylix = {
    # Enable Stylix for system-wide theming
    enable = true;

    # Set the wallpaper image
    image = ../../../../home/assets/wallpapers/groot.jpg;

    # Set the theme polarity (dark or light)
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";

    # Configure cursor theme
    cursor = {
      name = "Vimix-Cursors-White";
      package = pkgs.vimix-cursor-theme;
      size = 36;
    };

    # Configure system fonts
    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      # Set font sizes for different contexts
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 12;
        terminal = 12;
      };
    };

    # # Set opacity levels for different contexts
    # opacity = {
    #   # applications = 0.85;
    #   desktop = 0.40;
    #   # popups = 0.85;
    #   terminal = 0.85;
    # };
  };
}
