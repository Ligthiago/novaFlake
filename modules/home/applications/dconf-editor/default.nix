{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.dconf-editor;
in {
  options.configuration.applications.dconf-editor = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable dconf-editor module.
      dconf-editor is a GSettings editor.
      Source: https://gitlab.gnome.org/GNOME/dconf-editor
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.dconf-editor
    ];

    xdg.desktopEntries."ca.desrt.dconf-editor" = {
      name = "Dconf Editor";
      genericName = "Settings";
      categories = ["System"];
      type = "Application";
      terminal = false;
      icon = "ca.desrt.dconf-editor";
      comment = "Utility for editing GSettings";
      exec = "dconf-editor";
      settings = {
        StartupNotify = "true";
        Keywords = "Settings;Configuration;GTK;";
        DBusActivatable = "true";
      };
    };
  };
}
