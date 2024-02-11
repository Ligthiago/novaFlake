{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.musikcube;
in {
  options.modules.applications.musikcube = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable musikcube module.
      Musikcube is a terminal-based audio engine, library, player and server.
      Source: https://github.com/clangen/musikcube
      Documentation: https://github.com/clangen/musikcube/wiki/user-guide
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      musikcube
    ];

    xdg.desktopEntries."musikcube" = {
      name = "Musikcube";
      genericName = "Music Player";
      categories = ["Audio" "Music"];
      type = "Application";
      terminal = true;
      icon = "musikcube";
      comment = "Terminal-based music player";
      exec = "musikcube %U";
      settings = {
        Keywords = "Music;Audio;Player;Playlist;";
      };
    };
  };
}
