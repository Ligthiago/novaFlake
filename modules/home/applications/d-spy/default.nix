{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.d-spy;
in {
  options.configuration.applications.d-spy = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable d-spy module.
      D-spy is a D-Bus exploration tool
      Source: https://gitlab.gnome.org/GNOME/d-spy
    '');
    desktopName = mkOpt types.str "org.gnome.dspy" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      d-spy
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "D-spy";
      genericName = "D-Bus exploration tool";
      categories = ["Development"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.dspy";
      comment = "D-bus exploration utility";
      exec = "d-spy";
      settings = {
        StartupNotify = "true";
        Keywords = "GUI;Dbus;";
      };
    };
  };
}
