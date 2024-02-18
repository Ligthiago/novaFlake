{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.rclip;
in {
  options.configuration.tools.rclip = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable rclip module.
      rclip is a AI-Powered command-line photo search toollll
      Source: https://github.com/yurijmikhalevich/rclip
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rclip
    ];
  };
}
