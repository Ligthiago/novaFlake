{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.services.dunst;
in {
  options.configuration.services.dunst = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable dunst module.
      dunst is lightweight and customizable notification daemon 
      Source: https://github.com/dunst-project/dunst
      Documentation: https://dunst-project.org/documentation/
    '');
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
    };
  };
}
