{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.webApplications.yarr;
in {
  options.modules.webApplications.yarr = {
    enable = mkEnableOption (lib.mdDoc "Enable yarr module");
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
