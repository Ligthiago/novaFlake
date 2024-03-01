{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.amberol;
in {
  options.configuration.applications.amberol = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable amberol module.
      Amberol is a small and simple sound and music player
      Source: https://gitlab.gnome.org/World/amberol
    '');
    desktopName = mkOpt types.str "io.bassi.Amberol" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      amberol
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Amberol";
      genericName = "Music Player";
      categories = ["Audio" "Music" "AudioVideo"];
      type = "Application";
      terminal = false;
      icon = "io.bassi.Amberol";
      comment = "Graphical music player";
      exec = "amberol %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Music;Player;Audio;Playlist;";
      };
    };

    dconf.settings = {
      "io/bassi/Amberol" = {
        enable-recoloring = false;
      };
    };
  };
}
