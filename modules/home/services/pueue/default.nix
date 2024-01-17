{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.services.pueue;
in {
  options.modules.services.pueue = {
    enable = mkEnableOption (lib.mdDoc "Enable pueue module");
  };
  config = mkIf cfg.enable {
    services.pueue = {
      enable = true;
    };
  };
}
