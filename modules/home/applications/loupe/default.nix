{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.loupe;
in {
  options.configuration.applications.loupe = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable loupe module.
      Loupe is a image viewer.
      Source: https://gitlab.gnome.org/GNOME/loupe
    '');
    desktopName = mkOpt types.str "org.gnome.Loupe" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      loupe
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
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
