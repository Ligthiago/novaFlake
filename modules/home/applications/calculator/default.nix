{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.calculator;
in {
  options.configuration.applications.calculator = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable calculator module.
      gnome-calculator is a graphical calculator app
      Source: https://gitlab.gnome.org/GNOME/gnome-calculator
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.gnome-calculator
    ];

    xdg.desktopEntries."org.gnome.Calculator" = {
      name = "Calculator";
      genericName = "Calculator";
      categories = ["Utility" "Calculator"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.Calculator";
      comment = "Graphical utility to perform calculations";
      exec = "gnome-calculator";
      settings = {
        StartupNotify = "true";
        Keywords = "Calculation;Arithmetic;Scientific;Financial;";
      };
    };
  };
}
