{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.musikcube;
in {
  options.configuration.applications.musikcube = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable musikcube module.
      Musikcube is a terminal-based audio engine, library, player and server.
      Source: https://github.com/clangen/musikcube
      Documentation: https://github.com/clangen/musikcube/wiki/user-guide
    '');
    desktopName = mkOpt types.str "org.gnome.Loupe" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      musikcube
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
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
