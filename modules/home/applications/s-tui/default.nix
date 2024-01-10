{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.s-tui;
in {
  options.modules.applications.s-tui = {
    enable = mkEnableOption (lib.mdDoc "Enable s-tui module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      s-tui
      stress
    ];
    xdg.desktopEntries."stui" = {
      name = "S-tui";
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
