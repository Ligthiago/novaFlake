{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nova.services.tlp;
in {
  options.nova.services.tlp = {
    enable = mkEnableOption (lib.mdDoc "Enable tlp service for laptops");
  };
  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_DRIVER_OPMODE_ON_AC = "passive";
        CPU_DRIVER_OPMODE_ON_BAT = "passive";
        CPU_SCALING_GOVERNOR_ON_AC = "conservative";
        CPU_SCALING_GOVERNOR_ON_BAT = "consrvative";
      };
    };
  };
}
