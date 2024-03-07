{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.cavalier;
in {
  options.configuration.applications.cavalier = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable cavalier module.
      Cavalier is a grapical audio visualizer, based on cava.
      Source: https://github.com/NickvisionApps/Cavalier
    '');
    desktopName = mkOpt types.str "org.nickvision.cavalier" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cavalier
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Cavalier";
      genericName = "Audio Visualizer";
      categories = ["Audio" "AudioVideo"];
      type = "Application";
      terminal = false;
      icon = "org.nickvision.cavalier";
      comment = "Utility for audio visualisation, based on the cava";
      exec = "NickvisionCavalier.GNOME";
      settings = {
        StartupNotify = "true";
        Keywords = "Audio;Visualisation;Cava;";
        DBusActivatable = "true";
      };
    };
  };
}
