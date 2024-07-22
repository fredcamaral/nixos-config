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
    "zellij"
  ];

  programs = {
    # Enable and configure various CLI tools and applications

    # Configuration for the 'bat' cat clone
    bat = {
      enable = true;
    };

    # Configuration for the 'fd' find clone
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # Enable nix-index for querying available packages
    nix-index = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    # Enable the 'eza' modern ls replacement
    eza.enable = true;

    # PDF viewer configuration
    zathura = {
      enable = true;
      options = {
        sandbox = "none";
        selection-clipboard = "clipboard";
      };
    };

    # OBS Studio configuration
    obs-studio = {
      enable = true;
      plugins = with pkgs; [
        # List of OBS plugins
        obs-studio-plugins.obs-gstreamer
        obs-studio-plugins.obs-vkcapture
        obs-studio-plugins.obs-pipewire-audio-capture
        obs-studio-plugins.obs-multi-rtmp
        obs-studio-plugins.obs-move-transition
      ];
    };

    # Zsh shell configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "fino-time";
        plugins = [
          "git"
          "history"
          "wd"
        ];
      };
    };

    # Configuration for various other programs
    micro.enable = true;

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

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    go = {
      enable = true;
      goPath = "go/bin";
    };
  };
}
