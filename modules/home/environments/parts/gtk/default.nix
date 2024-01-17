{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
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
        @define-color window_bg_color #242424;
        @define-color window_fg_color #dddddd;
        @define-color view_bg_color #1e1e1e;
        @define-color view_fg_color #dddddd;
        @define-color headerbar_bg_color #323232;
        @define-color headerbar_fg_color #dddddd;
        @define-color headerbar_border_color transparent;
        @define-color headerbar_backdrop_color #323232;
        @define-color headerbar_shade_color transparent;
        @define-color headerbar_darker_shade_color transparent;
        @define-color sidebar_bg_color #242424;
        @define-color sidebar_fg_color #dddddd;
        @define-color sidebar_backdrop_color #242424;
        @define-color card_bg_color #363636;
        @define-color card_fg_color #dddddd;
        @define-color card_shade_color #242424;
      '';
      cssTweaks = ''
        .top-bar {
          background-color: #323232;
        }
        .navigation-sidebar {
          border-right: 1px solid #323232;
        }
        .close image {
          background-color: transparent;
          -gtk-icon-size: 20px;
        }
        .close:hover {
          background-color: #464646;
        }
        .maximize image {
          background-color: transparent;
          -gtk-icon-size: 20px;
        }
        .maximize:hover {
          background-color: #464646;
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
