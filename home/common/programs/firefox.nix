# home/programs/firefox.nix
{
  pkgs,
  pkgs-unstable,
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
  '';

  # Load custom CSS for Firefox UI
  userChrome = builtins.readFile ./firefox/userChrome.css;
  userContent = builtins.readFile ./firefox/userContent.css;
in {
  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox;
    profiles = {
      main = {
        isDefault = true;

        id = 0;
        name = "main";
        inherit settings search extraConfig userChrome userContent;
      };
    };
  };
}
