{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.celluloid;
in {
  options.modules.applications.celluloid = {
    enable = mkEnableOption (lib.mdDoc "Enable celluloid module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      celluloid
    ];

    xdg.desktopEntries."io.github.celluloid_player.Celluloid" = {
      name = "Celluloid";
      genericName = "Media Player";
      categories = ["Audio" "Video"];
      type = "Application";
      terminal = false;
      icon = "io.github.celluloid_player.Celluloid";
      comment = "Play videos";
      exec = "firejail celluloid %U";
      settings = {
        DBusActivatable = "true";
        StartupWMClass = "celluloid";
      };
    };
  };
}
