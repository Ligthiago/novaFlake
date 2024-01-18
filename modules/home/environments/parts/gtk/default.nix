{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.environments.parts.gtk;
  home = config.home.homeDirectory;
  user = config.home.username;
in {
  options.modules.environments.parts.gtk = {
    enable = mkEnableOption (lib.mdDoc "Enable gtk customisation module");
  };
  config = mkIf cfg.enable {
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
        @define-color headerbar_backdrop_color ${palette.background.bright};
        @define-color headerbar_shade_color transparent;
        @define-color headerbar_darker_shade_color transparent;
        @define-color sidebar_bg_color ${palette.background.dim};
        @define-color sidebar_fg_color ${palette.foreground.normal};
        @define-color sidebar_backdrop_color ${palette.background.dim};
        @define-color card_bg_color ${palette.background.shiny};
        @define-color card_fg_color ${palette.foreground.normal}; 
        @define-color card_shade_color ${palette.background.dim};
      '';
      cssTweaks = ''
        .top-bar {
          background-color: ${palette.background.normal};
        }
        .navigation-sidebar {
          border-right: ${geometry.border} ${palette.background.normal};
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

      '';
      bookmarksList = [
        "file:///${home}/Projects"
        "file:///${home}/Library"
        "file:///${home}/Games"
        "file:///${home}/Misc"
        "file:///${home}/Backups"
        "file:///${home}/Screenshots"
        "file:///${home}/.config Configuration"
        "file:///${home}/.mozilla/firefox/${user} Profile"
      ];
    in {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme.override {color = "brown";};
      };
      gtk4 = {
        extraCss = namedColors + cssTweaks;
      };
      gtk3 = {
        extraCss = namedColors;
        bookmarks =
          if config.xdg.userDirs.enable
          then bookmarksList
          else [];
      };
    };
  };
}
