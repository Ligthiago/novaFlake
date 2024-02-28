{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.resources;
in {
  options.configuration.applications.resources = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable resources module.
      Resources is a monitor for system resources and processes.
      Source: https://github.com/nokyan/resources
    '');
    desktopName = mkOpt types.str "net.nokyan.Resources" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      resources
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Resources";
      genericName = "System Monitor";
      categories = ["Utility" "Monitor"];
      type = "Application";
      terminal = false;
      icon = "net.nokyan.Resources";
      comment = "Graphical resource monitor";
      exec = "resources";
      settings = {
        StartupNotify = "true";
        Keywords = "Resource;Monitoring;Processes;Memory;Disks;Network;Statistics;";
      };
    };
  };
}
