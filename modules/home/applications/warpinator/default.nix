{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.warpinator;
in {
  options.configuration.applications.warpinator = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable warpinator module.
      warpinator is a utility for sharing files over the LAN
      Source: https://github.com/linuxmint/warpinator
    '');
    desktopName = mkOpt types.str "org.x.Warpinator" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cinnamon.warpinator
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Warpinator";
      genericName = "Sharing Utility";
      categories = ["Utility" "Network"];
      type = "Application";
      terminal = false;
      icon = "org.x.Warpinator";
      comment = "Utility for sharing files over the LAN";
      exec = "warpinator";
      settings = {
        StartupNotify = "true";
        Keywords = "GUI;Transfer;Airdrop;Exchange;Local;";
      };
    };
  };
}
