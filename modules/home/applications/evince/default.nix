{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.evince;
in {
  options.modules.applications.evince = {
    enable = mkEnableOption (lib.mdDoc "Enable evince module. Also need a system module");
  };
  config = mkIf cfg.enable {
    # For now preview dont work, need to configure PATH or something
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
