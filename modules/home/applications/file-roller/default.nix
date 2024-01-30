{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.file-roller;
in {
  options.modules.applications.file-roller = {
    enable = mkEnableOption (lib.mdDoc "Enable file-roller module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.file-roller
    ];

    xdg.desktopEntries."org.gnome.FileRoller" = {
      name = "Archive Manager";
      genericName = "Archive Manager";
      categories = ["Utility" "Compression" "Archiving"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.FileRoller";
      comment = "Graphical archive manager";
      exec = "file-roller %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Archive;tar;zip;rar;unpack;";
      };
    };
  };
}
