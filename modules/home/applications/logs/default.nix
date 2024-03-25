{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.logs;
in {
  options.configuration.applications.logs = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable logs module.
      Logs is a systemd journal viewer.
      Source: https://gitlab.gnome.org/GNOME/gnome-logs
    '');
    desktopName = mkOpt types.str "org.gnome.Logs" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.gnome-logs
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Logs";
      genericName = "Logs Viewer";
      categories = ["Utility" "Monitor"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.Logs";
      comment = "Graphical systemd journal viewer";
      exec = "gnome-logs";
      settings = {
        StartupNotify = "true";
        Keywords = "GUI;Logs;Monitoring;Systemd;Journal;Errors;";
      };
    };
  };
}
