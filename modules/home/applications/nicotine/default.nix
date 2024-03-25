{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.nicotine;
in {
  options.configuration.applications.nicotine = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable nicotine module.
      Nicotine-plus is a client for the SoulSeek peer-to-peer system
      Source: https://github.com/nicotine-plus/nicotine-plus
    '');
    desktopName = mkOpt types.str "org.nicotine_plus.Nicotine" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nicotine-plus
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Nicotine+";
      genericName = "Soulseek Client";
      categories = ["Network" "FileTransfer" "InstantMessaging" "Chat"];
      type = "Application";
      terminal = false;
      icon = "org.nicotine_plus.Nicotine";
      comment = "Graphical client for the Soulseek peer-to-peer network";
      exec = "nicotine";
      settings = {
        StartupNotify = "true";
        Keywords = "GUI;Chat;Soulseek;Messaging;Sharing;P2P;";
      };
    };
  };
}
