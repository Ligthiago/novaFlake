{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.secrets;
in {
  options.modules.applications.secrets = {
    enable = mkEnableOption (lib.mdDoc "Enable gnome-secrets module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome-secrets
    ];
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
