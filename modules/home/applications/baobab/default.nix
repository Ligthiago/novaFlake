{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.baobab;
in {
  options.modules.applications.baobab = {
    enable = mkEnableOption (lib.mdDoc "Enable baobab module");
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
