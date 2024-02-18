{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.nautilus;
in {
  options.configuration.applications.nautilus = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable nautilus module.
      Nautilus is a graphical file manager.
      Source: https://gitlab.gnome.org/GNOME/nautilus
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.nautilus
      gnome.adwaita-icon-theme
    ];
  };
}
