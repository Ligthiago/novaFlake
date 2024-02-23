{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.obs-studio;
in {
  options.configuration.applications.obs-studio = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable obs-studio module.
      OBS Studio is a application for live streaming and screen recording.
      Source: https://github.com/obsproject/obs-studio
    '');
    desktopName = mkOpt types.str "com.obsproject.Studio" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
    };

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "OBS Studio";
      genericName = "Streaming/Recording Application";
      categories = ["AudioVideo" "Recorder"];
      type = "Application";
      terminal = false;
      icon = "com.obsproject.Studio";
      comment = "Streaming and recording application";
      exec = "obs";
      settings = {
        Keywords = "Streaming;Recoarding,Screensharing,Video,Audio;";
        StartupNotify = "true";
        StartupWMClass = "obs";
      };
    };
  };
}
