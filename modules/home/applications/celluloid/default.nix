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
      comment = "Mpv-based video player";
      exec = "firejail celluloid %U";
      settings = {
        Keywords = "Audio;Video;Media;Player";
        DBusActivatable = "true";
      };
    };
  };
}
