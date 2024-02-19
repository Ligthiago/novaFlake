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
        //.navigation-sidebar {
        //  border-right: ${geometry.border} ${palette.background.normal};
        //}

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
        windowhandle{
          filter: opacity(1)
        }

      '';
      bookmarksList = [
        "file://${home}/Projects"
        "file://${home}/Library"
        "file://${home}/Games"
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
  };
}
