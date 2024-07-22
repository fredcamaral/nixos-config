# home/programs/firefox.nix
{
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    enableGnomeExtensions = true;
    profiles = {
      fredamaral = {
        id = 0;
        name = "space-main";
        isDefault = true;
        settings = import ./firefox-settings.nix;

        # Load custom CSS for Firefox UI
        userChrome = builtins.readFile ../assets/userChrome.css;
        userContent = builtins.readFile ../assets/userContent.css;

        # Configure search engines
        search = import ./firefox-search.nix;

        # Additional Firefox preferences
        extraConfig = ''
          user_pref("update_notifications.enabled", false);
        '';
      };
      dev = {
        id = 1;
        name = "space-dev";
        settings = import ./firefox-settings.nix;

        # Load custom CSS for Firefox UI
        userChrome = builtins.readFile ../assets/userChrome.css;
        userContent = builtins.readFile ../assets/userContent.css;

        # Configure search engines
        search = import ./firefox-search.nix;

        # Additional Firefox preferences
        extraConfig = ''
          user_pref("update_notifications.enabled", false);
        '';
      };
      qbit = {
        id = 2;
        name = "space-qbit";
        settings = import ./firefox-settings.nix;

        # Load custom CSS for Firefox UI
        userChrome = builtins.readFile ../assets/userChrome.css;
        userContent = builtins.readFile ../assets/userContent.css;

        # Configure search engines
        search = import ./firefox-search.nix;

        # Additional Firefox preferences
        extraConfig = ''
          user_pref("update_notifications.enabled", false);
        '';
      };
      notes = {
        id = 3;
        name = "space-notes";
        settings = import ./firefox-settings.nix;

        # Load custom CSS for Firefox UI
        userChrome = builtins.readFile ../assets/userChrome.css;
        userContent = builtins.readFile ../assets/userContent.css;

        # Configure search engines
        search = import ./firefox-search.nix;

        # Additional Firefox preferences
        extraConfig = ''
          user_pref("update_notifications.enabled", false);
        '';
      };
    };
  };
}
