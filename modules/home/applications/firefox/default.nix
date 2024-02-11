{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.firefox;
  user = config.home.username;
  home = config.home.homeDirectory;
in {
  options.modules.applications.firefox = {
     enable = mkOptEnable (lib.mdDoc ''
      Enable firefox module.
      Firefox is a customizable web browser.
      Source: https://www.mozilla.org/en-US/firefox/
    '');
  };
  
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        cfg = {
          speechSynthesisSupport = false;
        };
      };
      policies = {
        CaptivePortal = false;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableTelemetry = true;
        DisablePrivateBrowsing = true;
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "never";
        DisableFeedbackCommands = true;
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = false;
        OfferToSaveLogins = false;
        ShowHomeButton = false;
        NetworkPrediction = false;
        HardwareAcceleration = true;
        FirefoxHome = {
          Locked = true;
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
        };
        FirefoxSuggest = {
          Locked = true;
          WebSuggestions = true;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          SkipOnboarding = true;
          WhatsNew = false;
        };
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };
        PictureInPicture = {
          Enabled = false;
        };
      };

      profiles."${user}" = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];
        settings = {
          "app.normandy.api_url" = "";
          "app.normandy.enabled" = false;
          "app.update.auto" = false;
          "beacon.enabled" = false;
          "breakpad.reportURL" = "";
          "browser.cache.offline.enable" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "browser.crashReports.unsubmittedCheck.enabled" = false;
          "browser.disableResetPrompt" = true;
          "browser.newtab.preload" = false;
          "browser.safebrowsing.appRepURL" = "";
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.safebrowsing.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.selfsupport.url" = "";
          "browser.send_pings" = false;
          "browser.sessionstore.privacy_level" = 0;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.trimURLs" = false;
          "device.sensors.ambientLight.enabled" = false;
          "device.sensors.enabled" = false;
          "device.sensors.motion.enabled" = false;
          "device.sensors.orientation.enabled" = false;
          "device.sensors.proximity.enabled" = false;
          "dom.battery.enabled" = false;
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";
          "experiments.supported" = false;
          "extensions.getAddons.cache.enabled" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.greasemonkey.stats.optedin" = false;
          "extensions.greasemonkey.stats.url" = "";
          "extensions.shield-recipe-client.api_url" = "";
          "extensions.shield-recipe-client.enabled" = false;
          "extensions.webservice.discoverURL" = "";
          "media.eme.enabled" = false;
          "media.gmp-widevinecdm.enabled" = false;
          "media.video_stats.enabled" = false;
          "network.IDN_show_punycode" = true;
          "network.allow-experiments" = false;
          "network.cookie.cookieBehavior" = 1;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "network.http.referer.spoofSource" = true;
          "network.http.speculative-parallel-limit" = 0;
          "network.predictor.enable-prefetch" = false;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;
          "network.trr.mode" = 5;
          "pdfjs.enableScripting" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.query_stripping" = true;
          "privacy.usercontext.about_newtab_segregation.enabled" = true;
          "security.ssl.disable_session_identifiers" = true;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
          "signon.autofillForms" = false;

          # Telemetry
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.cachedClientID" = "";
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # Hardware acceleration and decoding
          "dom.webgpu.enabled" = true;
          "gfx.webrender.all" = true;
          "layers.gpu-process.enabled" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.gpu-process-decoder" = true;
          "media.hardware-video-decoding.enabled" = true;

          # Customization
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.uidensity" = 0;
          "svg.context-properties.content.enabled" = true;

          # Be simple and quiet
          "browser.aboutConfig.showWarning" = false;
          "browser.preferences.moreFromMozilla" = false;
          "reader.parse-on-load.enabled" = false;
          "browser.translations.automaticallyPopup" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "media.autoplay.default" = 1;
          "media.autoplay.enabled" = false;

          # Bypass Russian censorship
          "network.proxy.autoconfig_url" = "https://antizapret.prostovpn.org:8443/proxy.pac";
        };

        # Search engines configurations
        search = {
          default = "DuckDuckGo";
          force = true;
          order = [
            "DuckDuckGo"
            "Nix Packages"
            "MyNixOS"
            "Github"
          ];
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
            "MyNixOS" = {
              urls = [
                {
                  template = "https://mynixos.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              iconUpdateURL = "https://mynixos.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@mn"];
            };
            "Github" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "type";
                      value = "repositories";
                    }
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              iconUpdateURL = "https://github.githubassets.com/favicons/favicon-dark.png";
              definedAliases = ["@gh"];
            };

            "Bing".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
          };
        };
      };
    };

    # Apply custom theme
    home.file = let
      chrome = ".mozilla/firefox/${user}/chrome";
    in {
      "${chrome}" = {
        source = builtins.fetchGit {
          url = "https://github.com/Ligthiago/novaFirefox";
          rev = "c2d303964e49ac1e6b64ba45119839b9a4b1e87d";
        };
      };
    };

    # Create custom desktop entry
    xdg.desktopEntries."firefox" = {
      name = "Firefox";
      genericName = "Web Browser";
      categories = ["Network" "WebBrowser"];
      type = "Application";
      terminal = false;
      icon = "firefox";
      comment = "Web browser";
      exec = "firefox --name firefox %U";
      settings = {
        StartupNotify = "true";
        StartupWMClass = "firefox";
        Keywords = "Browser;Internet;Network;Web;";
      };
    };
  };
}
