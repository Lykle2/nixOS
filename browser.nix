{
  config,
  pkgs,
  ...
}:
  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in
  {
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      Cookies = {
        "Allow" = [
          # "https://google.com" # Example for future cookie allowances.
        ];
        "Locked" = true;
      };

      # Telemetry
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "duckduckgo.com";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"

      # Extensions
      ExtensionSettings = {
        # Dark Reader:
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
          permissions = "internal:privateBrowingAllowed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          permissions = "internal:privateBrowingAllowed";
        };
        # Remove YouTube Suggestions:
        "{21f1ba12-47e1-4a9b-ad4e-3a0260bbeb26}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/remove-youtube-s-suggestions/latest.xpi";
          installation_mode = "force_installed";
          permissions = "internal:privateBrowingAllowed";
        };
	# Maximize All Windows:
	"{0fb9fbf9-ede1-415b-ace5-25b216f3c087}" = {
	install_url = "https://addons.mozilla.org/firefox/downloads/file/3591243/maximize_all_windows-0.1.3.xpi";
	installation_mode = "force_installed";
	permissions = "internal:privateBrowsingAllowed";
      };
    };
      FirefoxHome = {
        "Search" = false;
      };
    
      HardwareAcceleration = true;

      # Preferences
      Preferences = {
        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.formfill.enable" = lock-false;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.urlbar.suggest.searches" = lock-false;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        "webgl.disabled" = false;
      };
    };
  };
}
