{pkgs, ...}: {
  # Module installing  as default browser
  home.packages = [pkgs.floorp];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.floorp}/bin/floorp";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "floorp.desktop";
    "x-scheme-handler/http" = "floorp.desktop";
    "x-scheme-handler/https" = "floorp.desktop";
    "x-scheme-handler/about" = "floorp.desktop";
    "x-scheme-handler/unknown" = "floorp.desktop";
  };

  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      bookmarks = {};

      settings = {
        "app.update.auto" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.aboutConfig.showWarning" = false;

        "extension.activeThemeID" = "firefox-compact-dark@mozilla.org";

        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        "browser.toolbars.bookmarks.visibility" = "never";

        "extensions.pocket.enabled" = false;

        "findBar.highlightAll" = true;
      };
    };
  };
}
