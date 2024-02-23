{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.inkscape;
in {
  options.configuration.applications.inkscape = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable inkscape module.
      Inkscape is a free and open source vector graphics editor.
      Source: https://gitlab.com/inkscape/inkscape
      Documentation: https://www.inkscape.org/
    '');
    desktopName = mkOpt types.str "org.inkscape.Inkscape" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      inkscape
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Inkscape";
      genericName = "Vector Graphics Editor";
      categories = ["Graphics" "VectorGraphics"];
      type = "Application";
      terminal = false;
      icon = "org.inkscape.Inkscape";
      comment = "Vector graphics editor";
      exec = "inkscape %F";
      settings = {
        StartupNotify = "true";
        Keywords = "Image;Editor;Drawing;Illustration;Vector;";
      };
    };
  };
}
