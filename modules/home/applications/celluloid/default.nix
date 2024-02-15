{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.celluloid;
in {
  options.modules.applications.celluloid = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable celluloid module.
      Celluloid is a simple GTK+ frontend for mpv
      Source: https://github.com/celluloid-player/celluloid
    '');
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
      exec = "celluloid %U";
      settings = {
        Keywords = "Audio;Video;Media;Player";
        DBusActivatable = "true";
      };
    };
  };
}
