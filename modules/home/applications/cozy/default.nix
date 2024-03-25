{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.cozy;
in {
  options.configuration.applications.cozy = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable cozy module.
      Cozy is a modern audiobook player
      Source: https://github.com/geigi/cozy
    '');
    desktopName = mkOpt types.str "com.github.geigi.cozy" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cozy
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Cozy";
      genericName = "Audio Book Player";
      categories = ["Audio" "AudioVideo" "Player"];
      type = "Application";
      terminal = false;
      icon = "com.github.geigi.cozy";
      comment = "Audio book player";
      exec = "com.github.geigi.cozy %U";
      settings = {
        StartupNotify = "true";
        Keywords = "GUI;Audiobook;Listen;";
      };
    };
  };
}
