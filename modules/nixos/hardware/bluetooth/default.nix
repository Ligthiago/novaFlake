{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.bluetooth;
in {
  options.modules.hardware.bluetooth = {
    enable = mkEnableOption (lib.mdDoc "Enable bluetooth module");
  };
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
    };
  };
}
