{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.evince;
in {
  options.modules.applications.evince = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable evince module.
      Evince is a document viewer for multiple document formats.
      Source: https://gitlab.gnome.org/GNOME/evince
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      evince
    ];
    xdg.desktopEntries."org.gnome.Evince" = {
      name = "Evince";
      genericName = "Document Viewer";
      categories = ["Graphics" "Office"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.Evince";
      comment = "Multi-page document viewer";
      exec = "evince %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Document;PDF;Presentation;Viewer;";
      };
    };
  };
}
