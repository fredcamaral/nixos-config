# home/programs/firefox.nix
{
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles = {
      fredamaral = {
        id = 0;
        name = "Fred Amaral";
        isDefault = true;
        settings = {
          # Enable custom CSS for Firefox UI
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Disable tab manager
          "browser.tabs.tabmanager.enabled" = false;

          # Move tabs out of title bar
          "browser.tabs.inTitlebar" = 0;

          # Disable keyboard accessibility for URL bar results menu
          "browser.urlbar.resultMenu.keyboardAccessible" = false;

          # Enable smooth scrolling
          "general.smoothScroll" = true;

          # Start with a blank window
          "browser.startup.blankWindow" = true;

          # Disable reset prompt
          "browser.disableResetPrompt" = true;

          # Disable new tab page
          "browser.newtabpage.enabled" = false;

          # Disable sponsored content on new tab page
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          # Disable Firefox View
          "browser.tabs.firefox-view" = false;

          # Always show bookmarks toolbar
          "browser.toolbars.bookmarks.visibility" = "always";

          # Fully disable Pocket
          "extensions.pocket.enabled" = false;
          "extensions.pocket.api" = "0.0.0.0";
          "extensions.pocket.loggedOutVariant" = "";
          "extensions.pocket.oAuthConsumerKey" = "";
          "extensions.pocket.onSaveRecs" = false;
          "extensions.pocket.onSaveRecs.locales" = "";
          "extensions.pocket.showHome" = false;
          "extensions.pocket.site" = "0.0.0.0";
          "browser.newtabpage.activity-stream.pocketCta" = "";
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        };

        # Load custom CSS for Firefox UI
        userChrome = builtins.readFile ../assets/userChrome.css;
        userContent = builtins.readFile ../assets/userContent.css;

        # Configure search engines
        search = {
          force = true;
          default = "DuckDuckGo";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            # Hide default search engines
            "Google".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
          };
        };

        # Additional Firefox preferences
        extraConfig = ''
          user_pref("update_notifications.enabled", false);
        '';
      };
    };
  };
}
