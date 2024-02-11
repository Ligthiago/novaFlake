{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.environments.parts.dconf;
in {
  options.modules.environments.parts.dconf = {
    enable = mkOptEnable (lib.mdDoc "Enable dconf module");
  };

  config = mkIf cfg.enable {
    dconf.settings = {
      "io/github/celluloid-player/celluloid" = {
        always-use-floating-controls = true;
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        monospace-font-name = "Iosevka Extended 10";
      };

      "org/gnome/desktop/wm/preferences" = {
        action-double-click-titlebar = "none";
        action-right-click-titlebar = "none";
        audible-bell = false;
      };

      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = "small-plus";
      };

      "org/gnome/nautilus/list-view" = {
        default-zoom-level = "medium";
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
        show-create-link = true;
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
