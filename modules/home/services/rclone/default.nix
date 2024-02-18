{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.services.rclone;
in {
  options.configuration.services.rclone = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable rclone module.
      rclone is a command-line program to sync files and directories to and from different cloud storage providers.
      Source: https://github.com/rclone/rclone
      Documentation: https://rclone.org/
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rclone
    ];
  };
}
