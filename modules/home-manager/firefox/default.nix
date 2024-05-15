{ lib, config, ... }:
let
  cfg = config.modules.firefox;
in {
  options.modules.firefox = { enable = lib.mkEnableOption "firefox"; };
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.lplawlor = {
        isDefault = true;
        search = {
          force = true;
          default = "DuckDuckGo";
          order = [
            "DuckDuckGo"
            "Google"
            "Wikipedia (en)"
            "WordReference (EN to FR)"
            "WordReference (FR to EN)"
          ];
          engines = {
            # Disable useless built-ins
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
            "Amazon.ca".metaData.hidden = true;
            
            # Shorter aliases for built-ins
            "Google".metaData.alias = "@g";
            "Wikipedia (en)".metaData.alias = "@w";
            "DuckDuckGo".metaData.alias = "@d";

            "YouTube" = {
              urls = [{
                template = "https://www.youtube.com/results?search_query={searchTerms}";
              }];
              iconUpdateURL = "https://youtube.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@y" ];
            };
            
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages?query={searchTerms}";
              }];
              iconUpdateURL = "https://nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@np" ];
            };

            "Nix Options" = {
              urls = [{
                template = "https://search.nixos.org/options?query={searchTerms}";
              }];
              iconUpdateURL = "https://nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@no" ];
            };

            "NixOS Wiki" = {
              urls = [{
                template = "https://nixos.wiki/index.php?search={searchTerms}";
              }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };

            "MyNixOS" = {
              urls = [{
                template = "https://mynixos.com/search?q={searchTerms}";
              }];
              iconUpdateURL = "https://mynixos.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@mn" ];
            };

            "WordReference (EN to FR)" = {
              urls = [{
                template = "https://www.wordreference.com/enfr/{searchTerms}";
              }];
              iconUpdateURL = "https://www.wordreference.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@ef" ];
            };

            "WordReference (FR to EN)" = {
              urls = [{
                template = "https://www.wordreference.com/fren/{searchTerms}";
              }];
              iconUpdateURL = "https://www.wordreference.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@fe" ];
            };
          };
        };
      };
    };
  };
}
