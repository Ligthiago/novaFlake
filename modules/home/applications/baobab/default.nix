{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.baobab;
in {
  options.modules.applications.baobab = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable baobab module.
      Baobab is a graphical disk usage analyzer.
      Source: https://gitlab.gnome.org/GNOME/baobab
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      baobab
    ];

    xdg.desktopEntries."org.gnome.baobab" = {
      name = "Baobab";
      genericName = "Disk Usage Analyzer";
      categories = ["System" "Filesystem"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.baobab";
      comment = "Disk usage analyzer";
      exec = "baobab %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Storage;Space;Disk;Stats;";
        DBusActivatable = "true";
      };
    };
  };
}
