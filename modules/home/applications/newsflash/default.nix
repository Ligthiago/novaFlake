{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.newsflash;
in {
  options.configuration.applications.newsflash = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable newsflash module.
      Newsflash is a RSS feed reader
      Source: https://gitlab.com/news-flash/news_flash_gtk
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      newsflash
    ];

    xdg.desktopEntries."io.gitlab.news_flash.NewsFlash" = {
      name = "Newsflash";
      genericName = "RSS Reader";
      categories = ["Network" "Feed"];
      type = "Application";
      terminal = false;
      icon = "io.gitlab.news_flash.NewsFlash";
      comment = "Modern RSS reader";
      exec = "io.gitlab.news_flash.NewsFlash";
      settings = {
        StartupNotify = "true";
        Keywords = "Feed;RSS;Reader;News;";
      };
    };
  };
}
