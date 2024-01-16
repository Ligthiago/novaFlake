{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.obs-studio;
in {
  options.modules.applications.obs-studio = {
    enable = mkEnableOption (lib.mdDoc "Enable obs-studio module");
  };
  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
    };
    #  xdg.desktopEntries."stui" = {
    #    name = "S-tui";
    #    genericName = "Stress Monitor";
    #    categories = ["System" "Monitor"];
    #    type = "Application";
    #    terminal = true;
    #    icon = "openhardwaremonitor";
    #    comment = "Terminal-based CPU stress monitoring utility";
    #    exec = "s-tui";
    #    settings = {
    #      Keywords = "Resource;Monitoring,Stress,Statistics,Processor;";
    #   };
    #  };
  };
}
