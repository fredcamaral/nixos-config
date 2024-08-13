# home/programs/kitty.nix
{
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;

    # Enable Zsh integration for better shell support
    shellIntegration.enableZshIntegration = true;

    settings = {
      # Set the number of lines to keep in scrollback
      scrollback_lines = 10000;

      # Disable the audio bell for a quieter experience
      enable_audio_bell = false;

      # Disable automatic update checks
      update_check_interval = 0;

      # Automatically copy selected text to clipboard
      copy_on_select = true;

      # Configure cursor appearance
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";

      # Disable shell integration cursor features
      shell_integration = "no-cursor";

      # Configure tab bar appearance and behavior
      tab_bar_edge = "bottom";
      tab_bar_min_tabs = 1;

      # Window layout
      inactive_text_alpha = "0.8";
      confirm_os_window_close = 0;

      # Customize tab title format
      # Shows: <tab_index>: <active_program> @ <working_directory>
      tab_title_template = "{index}: {tab.active_exe} @ {tab.active_wd}";
    };
  };
}
