{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.disks;
in {
  options.modules.applications.disks = {
    enable = mkEnableOption (lib.mdDoc "Enable gnome-disks module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.gnome-disk-utility
    ];
  };
}
