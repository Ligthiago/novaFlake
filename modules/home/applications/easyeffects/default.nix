{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.easyeffects;
in {
  options.configuration.applications.easyeffects = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable easyeffects module.
      easyeffects is a utility to apply audio effects for PipeWire applications.
      Source: https://github.com/wwmm/easyeffects
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      easyeffects
    ];

    xdg.desktopEntries."com.github.wwmm.easyeffects" = {
      name = "Easy Effects";
      genericName = "Sound Control Utility";
      categories = ["AudioVideo" "Audio"];
      type = "Application";
      terminal = false;
      icon = "com.github.wwmm.easyeffects";
      comment = "Sound effects control utility";
      exec = "easyeffects";
      settings = {
        StartupNotify = "true";
        Keywords = "Effects;Sound;Equalizer;Volume;";
        DBusActivatable = "true";
      };
    };
  };
}
