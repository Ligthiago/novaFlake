{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.tlp;
in {
  options.modules.services.tlp = {
    enable = mkEnableOption (lib.mdDoc "Enable tlp module");
  };
  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_DRIVER_OPMODE_ON_AC = "passive";
        CPU_DRIVER_OPMODE_ON_BAT = "passive";
        CPU_SCALING_GOVERNOR_ON_AC = "conservative";
        CPU_SCALING_GOVERNOR_ON_BAT = "conservative";
        CPU_SCALING_MIN_FREQ_ON_AC = "600000";
        CPU_SCALING_MIN_FREQ_ON_BAT = "600000";

        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wifi wwan";
      };
    };
  };
}
