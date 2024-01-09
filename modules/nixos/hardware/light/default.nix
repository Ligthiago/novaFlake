{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.light;
in {
  options.modules.hardware.light = {
    enable = mkEnableOption (lib.mdDoc "Enable light service for brightness control");
  };
  config = mkIf cfg.enable {
    programs.light = {
      enable = true;
    };
  };
}
