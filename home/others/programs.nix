# home/programs.nix
{
  pkgs,
  lib,
  ...
}: {
  imports = map (program: ./programs/${program}.nix) [
    "git"
    "firefox"
    "vscode"
    "kitty"
  ];

  programs = {
    atuin = {
      enable = true;
      enableZshIntegration = false;
    };

    # A cat clone with syntax highlighting and Git integration
    bat = {
      enable = true;
    };

    # A process viewer, a more feature-rich alternative to top
    bottom.enable = true;

    # A more interactive and user-friendly top alternative
    btop.enable = true;

    # A tool for managing project-specific environment variables
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # A modern replacement for ls with color and icons
    eza.enable = true;

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # An interactive process viewer for Unix
    htop.enable = true;

    # A lightweight, command-line JSON processor
    jq.enable = true;

    # A simple terminal UI for git commands
    lazygit.enable = true;

    # A terminal-based text editor
    micro.enable = true;

    # A highly customizable text editor
    neovim = {
      enable = true;
      # Add any neovim configurations here
    };

    # A tool for querying available Nix packages
    nix-index = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    # # A versatile streaming software and video recording application
    obs-studio = {
      enable = true;
      plugins = with pkgs; [
        obs-studio-plugins.obs-gstreamer
        obs-studio-plugins.obs-vkcapture
        obs-studio-plugins.obs-pipewire-audio-capture
        obs-studio-plugins.obs-multi-rtmp
        obs-studio-plugins.obs-move-transition
        obs-studio-plugins.wlrobs
      ];
    };

    # A fast, feature-rich alternative to grep
    ripgrep.enable = true;

    # A terminal multiplexer
    tmux.enable = true;

    # A modern file manager for the terminal
    yazi = {
      enable = true;
      # Integrations
      enableZshIntegration = true;
      # General settings
      settings = {
        manager = {
          # Layout
          ratio = [1 2 5];
          show_hidden = false;
          show_symlink = true;
          # Sorting
          sort_by = "modified";
          sort_dir_first = true;
          sort_reverse = true;
        };
        log = {
          enabled = false;
        };
      };
      # Keybindings, nothing for now
      keymap = {};
    };

    # A lightweight PDF and document viewer
    zathura = {
      enable = true;
      options = {
        sandbox = "none";
        selection-clipboard = "clipboard";
      };
    };

    # A smarter cd command with interactive directory jumping
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # A powerful shell with many features
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "gnzh";
        plugins = [
          "git"
          "history"
          "wd"
        ];
      };
    };
  };
}
