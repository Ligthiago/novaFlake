{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.s-tui;
in {
  options.configuration.applications.s-tui = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable s-tui module.
      s-yui is a terminal-based CPU stress and monitoring utility.
      Source: https://github.com/amanusk/s-tui
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      s-tui
      stress
    ];

    xdg.desktopEntries."stui" = {
      name = "Stress Monitor";
      genericName = "Stress Monitor";
      categories = ["System" "Monitor"];
      type = "Application";
      terminal = true;
      icon = "openhardwaremonitor";
      comment = "Terminal-based CPU stress monitoring utility";
      exec = "s-tui";
      settings = {
        Keywords = "Resource;Monitoring,Stress,Statistics,Processor;";
      };
    };
  };
}
