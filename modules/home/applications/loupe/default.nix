{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.loupe;
in {
  options.modules.applications.loupe = {
     enable = mkOptEnable (lib.mdDoc ''
      Enable loupe module.
      Loupe is a image viewer.
      Source: https://gitlab.gnome.org/GNOME/loupe
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      loupe
    ];

    xdg.desktopEntries."org.gnome.Loupe" = {
      name = "Loupe";
      genericName = "Image Viewer";
      categories = ["Graphics" "Viewer"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.Loupe";
      comment = "Simple and fast image viewer";
      exec = "loupe %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Image;Picture;Graphics;Viewer;";
        DBusActivatable = "true";
      };
    };
  };
}
