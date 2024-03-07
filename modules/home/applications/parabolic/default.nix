{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.parabolic;
in {
  options.configuration.applications.parabolic = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable parabolic module.
      Parabolic is a graphical media downloader based on yt-dlp.
      Source: https://github.com/NickvisionApps/Parabolic
    '');
    desktopName = mkOpt types.str "org.nickvision.tubeconverter" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      parabolic
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Parabolic";
      genericName = "Media Downloader";
      categories = ["Network" "AudioVideo"];
      type = "Application";
      terminal = false;
      icon = "org.nickvision.tubeconverter";
      comment = "Utility for downloading media based on yt-dlp";
      exec = "NickvisionTubeConverter.GNOME";
      settings = {
        StartupNotify = "true";
        Keywords = "YouTube;Downloader;yt-dlp;Video;Audio;";
        DBusActivatable = "true";
      };
    };
  };
}
