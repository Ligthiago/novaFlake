{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.services.pueue;
in {
  options.modules.services.pueue = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable pueue module.
      pueue is  a command-line task management tool.
      Source: https://github.com/Nukesor/pueue
    '');
  };

  config = mkIf cfg.enable {
    services.pueue = {
      enable = true;
    };
  };
}
