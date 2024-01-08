{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nova.hardware.light;
in {
  options.nova.hardware.light = {
    enable = mkEnableOption (lib.mdDoc "Enable light service for brightness control");
  };
  config = mkIf cfg.enable {
    programs.light = {
      enable = true;
    };
  };
}
