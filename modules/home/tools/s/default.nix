{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.s;
in {
  options.configuration.tools.s = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable s module.
      s is a command-line program, that allow open a web search from terminal.
      Source: https://github.com/zquestz/s
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nova.s
    ];
  };
}
