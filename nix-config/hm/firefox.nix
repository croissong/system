{ pkgs, ... }:
let
  bookmarks = builtins.fromJSON (builtins.readFile ../bookmarks.json);
in
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      path = "kxzh8tid.default";
      userChrome = ''

        #TabsToolbar { visibility: collapse; }
      '';

      bookmarks = {
        force = true;
        settings = bookmarks;
      };

      settings = {
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.remotetab" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.openpage" = true;

        "browser.search.region" = "DE";

        # disable mouse pinch zoom
        "apz.allow_zooming" = false;
        "browser.gesture.pinch.in" = "";
        "browser.gesture.pinch.out" = "";
        # disable mouse wheel zoom
        "mousewheel.with_control.action" = 1;

        "extensions.formautofill.creditCards.enabled" = false;

        "signon.firefoxRelay.feature" = false;

        "browser.aboutConfig.showWarning" = false;
        "browser.startup.page" = 3;
        "browser.startup.homepage" = "about:firefoxview#opentabs";
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.translations.automaticallyPopup" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "intl.accept_languages" = "en";
      };

      search = {
        default = "Google";
        force = true;
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
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "Github" = {
            urls = [ { template = "https://github.com/search?q={searchTerms}&type=repositories"; } ];
            iconUpdateURL = "https://github.githubassets.com/favicons/favicon.svg";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@gh" ];
          };

          "Google".metaData.alias = "@g";

          "Bing".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "Amazon.de".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };
    };

    policies = {
      # https://mozilla.github.io/policy-templates/

      DefaultDownloadDirectory = "/tmp/";
      DisableAppUpdate = true;
      DisableFirefoxStudies = true;
      DisableFirefoxScreenshots = true;
      DisablePocket = true;

      DontCheckDefaultBrowser = true;
      PasswordManagerEnabled = false;
      PictureInPicture = {
        Enabled = false;
        Locked = true;
      };
      PromptForDownloadLocation = true;
      RequestedLocales = [ "en" ];
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = true;
        UrlbarInterventions = true;
        SkipOnboarding = true;
      };

      # https://mozilla.github.io/policy-templates/#extensionsettings
      # about:support
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "extension@tabliss.io" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tabliss/latest.xpi";
        };
        "de-DE@dictionaries.addons.mozilla.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/dictionary-german/latest.xpi";
        };
        "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/auto-tab-discard/latest.xpi";
        };

        "brotab_mediator@example.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/brotab/latest.xpi";
        };

        "duplicate-tab@firefox.stefansundin.com" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duplicate-tab-shortcut/latest.xpi";
        };

        # "*" = {
        #   installation_mode = "blocked";
        # };
      };
    };
  };
}
