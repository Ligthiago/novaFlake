{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.webApplications.yarr;
in {
  options.modules.webApplications.yarr = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable yarr module.
      yarr is a web-based rss reader.
      Source: https://github.com/nkanaev/yarr
    '');
  };
  
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yarr
    ];

    xdg.desktopEntries."yarr" = {
      name = "Yarr";
      genericName = "RSS Reader";
      categories = ["Network" "Feed"];
      type = "Application";
      terminal = false;
      icon = "rss";
      comment = "Web-based RSS Reader";
      exec = "yarr -open";
      settings = {
        Keywords = "RSS;Reader;Feed;Web";
      };
    };
  };
}
