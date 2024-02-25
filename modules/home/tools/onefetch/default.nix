{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.onefetch;
in {
  options.configuration.tools.onefetch = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable onefetch module.
      onefetch is a command-line Git information tool.
      Source: https://github.com/o2sh/onefetch
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      onefetch
    ];
  };
}
