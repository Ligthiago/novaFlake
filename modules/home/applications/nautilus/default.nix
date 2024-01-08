{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.nautilus;
in {
  options.modules.applications.nautilus = {
    enable = mkEnableOption (lib.mdDoc "Enable nautilus module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.nautilus
      gnome.adwaita-icon-theme
    ];
  };
}
