# home/programs/zellij.nix
{
  pkgs,
  lib,
  ...
}: {
  programs.zellij = {
    enable = true;
    settings = {
      # Use Zsh as the default shell
      default_shell = "zsh";

      # Enable mouse support
      mouse_mode = true;

      # Clipboard settings
      copy_on_select = true;
      copy_command = "wl-copy";
      copy_clipboard = "primary";

      # Layout and mode settings
      default_layout = "default";
      default_mode = "normal";

      # UI settings
      simplified_ui = false;
      ui = {
        pane_frames = {
          rounded_corners = true;
          hide_session_name = true;
        };
      };

      # Configure plugins
      plugins = {
        # Built-in plugins
        tab-bar = {path = "tab-bar";};
        status-bar = {path = "status-bar";};
        strider = {path = "strider";};
        compact-bar = {path = "compact-bar";};
        # Custom plugins
        startup = {path = "layout/startup.kdl";};
      };
    };
  };

  # Define default layout
  xdg.configFile."zellij-default-layout" = {
    enable = true;
    target = "zellij/layouts/default.kdl";
    text = ''
      layout {
        default_tab_template {
          children
          pane size=1 borderless=true {
              plugin location="zellij:compact-bar"
          }
        }
        tab name="main" {
          pane
        }
      }
    '';
  };

  # Define custom keybindings
  xdg.configFile."zellij-keybinds" = {
    enable = true;
    target = "zellij/keybinds/default.kdl";
    text = ''
      keybinds {
        normal {
            bind "Alt g" { SwitchToMode "locked"; }
            bind "Alt p" { SwitchToMode "pane"; }
        }
        pane {
            bind "h" "Left" { MoveFocus "Left"; }
            bind "l" "Right" { MoveFocus "Right"; }
            bind "j" "Down" { MoveFocus "Down"; }
            bind "k" "Up" { MoveFocus "Up"; }
            bind "p" { SwitchFocus; }
        }
        locked {
            bind "Ctrl g" { SwitchToMode "normal"; }
        }
        tab {
          bind "Alt t" { SwitchToMode "Normal"; }
          bind "Alt r" { SwitchToMode "RenameTab"; TabNameInput 0; }
          bind "Alt Left" "Alt Up" { GoToPreviousTab; }
          bind "Alt Right" "Alt Down" { GoToNextTab; }
          bind "Alt n" { NewTab; SwitchToMode "Normal"; }
          bind "Alt x" { CloseTab; SwitchToMode "Normal"; }
        }
        shared_except "locked" {
          bind "Alt g" { SwitchToMode "Locked"; }
          bind "Alt q" { Quit; }
        }
      }
    '';
  };

  # Define color themes
  xdg.configFile."zellij-themes" = {
    enable = true;
    target = "zellij/themes/default.kdl";
    text = ''
      themes {
        dracula {
          fg 248 248 242
          bg 40 42 54
          black 0 0 0
          red 255 85 85
          green 80 250 123
          yellow 241 250 140
          blue 98 114 164
          magenta 255 121 198
          cyan 139 233 253
          white 255 255 255
          orange 255 184 108
        }
        gruvbox-light {
          fg 60 56 54
          bg 251 82 75
          black 40 40 40
          red 205 75 69
          green 152 151 26
          yellow 215 153 33
          blue 69 133 136
          magenta 177 98 134
          cyan 104 157 106
          white 213 196 161
          orange 214 93 14
        }
        gruvbox-dark {
          fg "#D5C4A1"
          bg "#282828"
          black "#3C3836"
          red "#CC241D"
          green "#98971A"
          yellow "#D79921"
          blue "#3C8588"
          magenta "#B16286"
          cyan "#689D6A"
          white "#FBF1C7"
          orange "#D65D0E"
        }
      }
    '';
  };
}
