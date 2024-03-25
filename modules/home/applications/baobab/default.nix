{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.baobab;
in {
  options.configuration.applications.baobab = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable baobab module.
      Baobab is a graphical disk usage analyzer.
      Source: https://gitlab.gnome.org/GNOME/baobab
    '');
    desktopName = mkOpt types.str "org.gnome.baobab" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      baobab
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
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
        Keywords = "GUI;Storage;Space;Disk;Stats;";
        DBusActivatable = "true";
      };
    };
  };
}
