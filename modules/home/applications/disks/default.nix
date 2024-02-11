{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.disks;
in {
  options.modules.applications.disks = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable gnome-disks module.
      Gnome-disks is a tool for dealing with storage devices.
      Source: https://gitlab.gnome.org/GNOME/gnome-disk-utility
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.gnome-disk-utility
    ];
  };
}
