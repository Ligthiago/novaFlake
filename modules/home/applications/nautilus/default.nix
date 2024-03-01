{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.nautilus;
in {
  options.configuration.applications.nautilus = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable nautilus module.
      Nautilus is a graphical file manager.
      Source: https://gitlab.gnome.org/GNOME/nautilus
    '');
    desktopName = mkOpt types.str "org.gnome.Nautilus" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.nautilus
      gnome.adwaita-icon-theme
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Nautilus";
      genericName = "File Manager";
      categories = ["Utility" "FileManager"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.Nautilus";
      comment = "Graphical file manager";
      exec = "nautilus --new-window %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Files;Explore;Directory;Folder;Browse;";
        DBusActivatable = "true";
      };
    };

    dconf.settings = {
      "org/gnome/nautilus/icon-view" = {
        captions = ["size" "none" "none"];
        default-zoom-level = "small-plus";
      };

      "org/gnome/nautilus/list-view" = {
        default-visible-columns = ["name" "size" "date_modified"];
        default-zoom-level = "medium";
        use-tree-view = true;
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "icon-view";
        fts-enabled = true;
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
        show-create-link = true;
      };
    };
  };
}
