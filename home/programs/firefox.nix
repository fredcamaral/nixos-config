# home/programs/firefox.nix
{
  pkgs,
  lib,
  ...
}: let
  # Import Firefox settings
  settings = import ./firefox/firefox-settings.nix;

  # Import Firefox search engines
  search = import ./firefox/firefox-search.nix {inherit pkgs;};

  # Extra configuration for Firefox
  extraConfig = ''
    user_pref("update_notifications.enabled", false);
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
  '';

  # Load custom CSS for Firefox UI
  userChrome = builtins.readFile ./firefox/userChrome.css;
  userContent = builtins.readFile ./firefox/userContent.css;
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles = {
      main = {
        isDefault = true;

        id = 0;
        name = "space-main";
        inherit settings search extraConfig userChrome userContent;
      };
      dev = {
        id = 1;
        name = "space-dev";
        inherit settings search extraConfig userChrome userContent;
      };
      qbit = {
        id = 2;
        name = "space-qbit";
        inherit settings search extraConfig userChrome userContent;
      };
      notes = {
        id = 3;
        name = "space-notes";
        inherit settings search extraConfig userChrome userContent;
      };
    };
  };
}
