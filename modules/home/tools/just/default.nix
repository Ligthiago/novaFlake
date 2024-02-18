{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.just;
in {
  options.configuration.tools.just = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable just module.
      Just is a handy way to save and run project-specific commands.
      Source: https://github.com/casey/just
      Documentation: https://just.systems/man/en/
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      just
    ];
  };
}
