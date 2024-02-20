{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.easyeffects;
in {
  options.configuration.applications.easyeffects = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable easyeffects module.
      easyeffects is a utility to apply audio effects for PipeWire applications.
      Source: https://github.com/wwmm/easyeffects
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      easyeffects
      pamixer
    ];

    # xdg.desktopEntries."org.gnome.Calculator" = {
    #   name = "Calculator";
    #   genericName = "Calculator";
    #   categories = ["Utility" "Calculator"];
    #   type = "Application";
    #   terminal = false;
    #   icon = "org.gnome.Calculator";
    #   comment = "Grapical tool to perform calculations";
    #   exec = "gnome-calculator";
    #   settings = {
    #     StartupNotify = "true";
    #     Keywords = "Calculation;Arithmetic;Scientific;Financial;";
    #   };
    # };
  };
}
