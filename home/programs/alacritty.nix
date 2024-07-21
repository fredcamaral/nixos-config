# home/programs/alacritty.nix
{
  pkgs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      # Window Configuration
      window = {
        # Remove window decorations
        decorations = "ButtonLess";

        # Set window padding
        padding = {
          x = 10;
          y = 10;
        };

        # Set window opacity
        opacity = lib.mkForce 0.90;
      };

      # Cursor configuration
      mouse = {
        # Hide cursor when typing
        hide_when_typing = true;
      };
      cursor = {
        style = {
          # Use block cursor shape
          shape = "Block";
          # Enable cursor blinking
          blinking = "On";
        };
        # Make cursor hollow when window is not focused
        unfocused_hollow = true;
      };

      # Selection configuration
      selection = {
        # Automatically copy selected text to clipboard
        save_to_clipboard = true;
      };

      # Enable live config reloading
      live_config_reload = true;

      # Custom key bindings (empty for now)
      keyboard.bindings = [];

      # Import theme configuration
      import = ["~/repos/nix-configs/home/alacritty/themes/catppuccin_macchiato.toml"];
    };
  };
}
