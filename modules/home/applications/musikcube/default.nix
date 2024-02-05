{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.musikcube;
in {
  options.modules.applications.musikcube = {
    enable = mkEnableOption (lib.mdDoc ''
      Enable musikcube module
      Musikcube is a terminal-based audio engine, library, player and sezrver.
      Documentation: https://github.com/clangen/musikcube/wiki/user-guide
      Github: https://github.com/clangen/musikcube
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
