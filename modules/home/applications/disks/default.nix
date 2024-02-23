{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.disks;
in {
  options.configuration.applications.disks = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable gnome-disks module.
      Gnome-disks is a tool for dealing with storage devices.
      Source: https://gitlab.gnome.org/GNOME/gnome-disk-utility
    '');
    desktopName = mkOpt types.str "org.gnome.DiskUtility" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.gnome-disk-utility
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Disks";
      genericName = "Drive Manager";
      categories = ["Utility"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.DiskUtility";
      comment = "Utility for managing drives and external media";
      exec = "gnome-disks";
      settings = {
        StartupNotify = "true";
        Keywords = "Disk;Drive;Partition;Write;Mount;";
        DBusActivatable = "true";
      };
    };
  };
}
