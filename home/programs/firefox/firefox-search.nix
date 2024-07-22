{pkgs, ...}: {
  force = true;
  default = "DuckDuckGo";
  engines = {
    # Search for NixOS Packages
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
    # Search for NixOS Wiki
    "NixOS Wiki" = {
      urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
      iconUpdateURL = "https://nixos.wiki/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["@nw"];
    };

    # Hide default search engines
    "Google".metaData.hidden = true;
    "Amazon.com".metaData.hidden = true;
    "Bing".metaData.hidden = true;
    "eBay".metaData.hidden = true;
  };
}
