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
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cinnamon.warpinator
    ];

    xdg.desktopEntries."org.x.Warpinator" = {
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
        Keywords = "Transfer;Airdrop;Exchange;Local;";
      };
    };
  };
}
