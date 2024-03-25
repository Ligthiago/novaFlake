{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.libreoffice;
in {
  options.configuration.applications.libreoffice = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable libreoffice module.
      Libreoffice is a free and powerful office suite.
      Source: https://www.libreoffice.org/
    '');
    desktopName = mkOpt types.str "libreoffice" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice-fresh
    ];

    xdg.desktopEntries = {
      "${cfg.desktopName}" = {
        name = "LibreOffice";
        genericName = "Office Suit";
        categories = ["Office"];
        type = "Application";
        terminal = false;
        icon = "startcenter";
        comment = "Powerful office suite";
        exec = "libreoffice %U";
        settings = {
          StartupNotify = "true";
          Keywords = "GUI;Document;Write;Presentation;Viewer;Spreadsheet";
        };
      };
      # Oh God there's so many of them and none of them just called "libreoffice".
      # Basically, we remove all the default desktop entries from menus and instead create a unified, proper one above.
      # It just works
      "startcenter" = {
        name = "LibreOffice";
        noDisplay = true;
      };
      "writer" = {
        name = "LibreOffice Writer";
        noDisplay = true;
      };
      "impress" = {
        name = "LibreOffice Impress";
        noDisplay = true;
      };
      "math" = {
        name = "LibreOffice Math";
        noDisplay = true;
      };
      "base" = {
        name = "LibreOffice Base";
        noDisplay = true;
      };
      "draw" = {
        name = "LibreOffice Draw";
        noDisplay = true;
      };
      "calc" = {
        name = "LibreOffice Calc";
        noDisplay = true;
      };
    };
  };
}
