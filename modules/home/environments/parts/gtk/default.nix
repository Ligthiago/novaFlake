{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.environments.parts.gtk;
  home = config.home.homeDirectory;
  user = config.home.username;
in {
  options.configuration.environments.parts.gtk = {
    enable = mkOptEnable (lib.mdDoc "Enable gtk module");
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      adw-gtk3
    ];

    home.pointerCursor = {
      gtk.enable = true;
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 24;
    };

    gtk = let
      namedColors = ''
        @define-color accent_color ${palette.accents.blue};
        @define-color accent_bg_color ${palette.accents.blue};
        @define-color accent_fg_color ${palette.foreground.normal};

        @define-color destructive_color ${palette.accents.red};
        @define-color destructive_bg_color ${palette.accents.red};
        @define-color destructive_fg_color ${palette.foreground.normal};

        @define-color success_color ${palette.accents.green};
        @define-color success_bg_color ${palette.accents.green};
        @define-color success_fg_color ${palette.foreground.normal};

        @define-color warning_color ${palette.accents.yellow};
        @define-color warning_bg_color ${palette.accents.yellow};
        @define-color warning_fg_color ${palette.foreground.normal};

        @define-color error_color ${palette.accents.red};
        @define-color error_bg_color ${palette.accents.red};
        @define-color error_fg_color ${palette.foreground.normal};

        @define-color window_bg_color ${palette.background.dim};
        @define-color window_fg_color ${palette.foreground.normal};
        @define-color view_bg_color ${palette.background.dark};
        @define-color view_fg_color ${palette.foreground.normal};
        @define-color headerbar_bg_color ${palette.background.normal};
        @define-color headerbar_fg_color ${palette.foreground.normal};
        @define-color headerbar_border_color transparent;
        @define-color headerbar_backdrop_color ${palette.background.normal};
        @define-color headerbar_shade_color transparent;
        @define-color headerbar_darker_shade_color transparent;

        @define-color sidebar_bg_color ${palette.background.dim};
        @define-color sidebar_fg_color ${palette.foreground.normal};
        @define-color sidebar_backdrop_color ${palette.background.dim};
        @define-color sidebar_shade_color transparent;

        @define-color secondary_sidebar_bg_color ${palette.background.dim};
        @define-color secondary_sidebar_fg_color ${palette.foreground.normal};
        @define-color secondary_sidebar_backdrop_color ${palette.background.dim};
        @define-color secondary_sidebar_shade_color transparent;

        @define-color card_bg_color ${palette.background.shiny};
        @define-color card_fg_color ${palette.foreground.normal};
        @define-color card_shade_color transparent;

        @define-color shade_color transparent;
        @define-color popover_shade_color transparent;
      '';
      cssTweaks = ''
        .top-bar {
          background-color: ${palette.background.normal};
        }

        .custom-sidebar scrolledwindow viewport{
        border-right: 1px solid #323232;
        }
        .custom-sidebar scrolledwindow{
        border-right: 1px solid #161616;
        }
        .sidebar-pane scrolledwindow viewport{
        border-right: 1px solid #323232;
        }
        .sidebar-pane scrolledwindow{
        border-right: 1px solid #161616;
        }

        .top-bar {
          border-bottom: 1px solid #161616;
        }
        stack .top-bar {
         border:none;
        }
        .sidebar-pane viewport{
          border-right: 1px solid #161616;
        }

        .close image {
          background-color: transparent;
          -gtk-icon-size: 20px;
        }
        .close:hover {
          background-color: ${palette.background.bright};
        }
        .maximize image {
          background-color: transparent;
          -gtk-icon-size: 20px;
        }
        .maximize:hover {
          background-color: ${palette.background.bright};
        }
        .mimimize image {
          background-color: transparent;
          -gtk-icon-size: 20px;
        }
        .minimize:hover {
          background-color: ${palette.background.bright};
        }

        windowhandle{
          filter: opacity(1)
        }
        .boxed-list{
          border: 1px solid #464646;
        }
        .boxed-list row {
          border-bottom: 1px solid #242424;
        }
        .boxed-list row row {
          border-bottom: none;
        }
        .boxed-list row:last-child{
          border-bottom: none;
        }
        .menu contents, .menu arrow{
          border: 1px solid #464646;
        }
        .menu scrolledwindow, .menu viewport{
          border-right: none;
        }

      '';
      bookmarksList = [
        "file://${home}/Projects"
        "file://${home}/Library"
        (mkIf (config.configuration.applications.lutris.enable) "file://${home}/Games")
        "file://${home}/Misc"
        "file://${home}/Backups"
        "file://${home}/Pictures/Screenshots"
        "file://${config.xdg.configHome} Configuration"
        "file://${home}/.mozilla/firefox/${user} Profile"
        (mkIf (config.configuration.applications.obsidian.enable) "file://${home}/Vaults")
      ];
    in {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        # package = pkgs.gnome.gnome-themes-extra;
      };
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
      gtk4 = {
        extraCss = namedColors + cssTweaks;
      };
      gtk3 = {
        extraCss = namedColors + cssTweaks;
        bookmarks =
          if config.xdg.userDirs.enable
          then bookmarksList
          else [];
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        monospace-font-name = "Iosevka Extended 10";
      };

      "org/gnome/desktop/wm/preferences" = {
        action-double-click-titlebar = "none";
        action-right-click-titlebar = "none";
        audible-bell = false;
      };

      "org/gtk/gtk4/settings/debug" = {
        inspector-warning = false;
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
      };

      "org/gtk/settings/debug" = {
        inspector-warning = false;
      };

      "org/gtk/settings/file-chooser" = {
        show-hidden = true;
        show-size-column = true;
        show-type-column = true;
        sort-column = "modified";
        sort-directories-first = false;
        sort-order = "descending";
        type-format = "category";
      };
    };
  };
}
