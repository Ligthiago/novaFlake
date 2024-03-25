{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.dissent;
in {
  options.configuration.applications.dissent = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable dissent module.
      Dissent is a third-party Discord client
      Source: https://github.com/diamondburned/dissent
    '');
    desktopName = mkOpt types.str "so.libdb.dissent" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dissent
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Dissent";
      genericName = "Discord chat client";
      categories = ["Network" "Chat" "InstantMessaging"];
      type = "Application";
      terminal = false;
      icon = "so.libdb.dissent";
      comment = "Discord chat client";
      exec = "dissent";
      settings = {
        StartupNotify = "true";
        Keywords = "GUI;Discord;Chat;Messaging;";
      };
    };
  };
}
