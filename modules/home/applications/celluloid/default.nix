{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.celluloid;
in {
  options.configuration.applications.celluloid = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable celluloid module.
      Celluloid is a simple GTK+ frontend for mpv
      Source: https://github.com/celluloid-player/celluloid
    '');
    desktopName = mkOpt types.str "io.github.celluloid_player.Celluloid" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      celluloid
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Celluloid";
      genericName = "Media Player";
      categories = ["Audio" "Video"];
      type = "Application";
      terminal = false;
      icon = "io.github.celluloid_player.Celluloid";
      comment = "Mpv-based video player";
      exec = "celluloid %U";
      settings = {
        Keywords = "GUI;Audio;Video;Media;Player";
        DBusActivatable = "true";
      };
    };

    dconf.settings = {
      "io/github/celluloid-player/celluloid" = {
        always-use-floating-controls = true;
      };
    };
  };
}
