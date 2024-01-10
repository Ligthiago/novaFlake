{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.gammastep;
in {
  options.modules.services.gammastep = {
    enable = mkEnableOption (lib.mdDoc "Enable gammastep module");
  };
  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = 0.0;
      longitude = 0.0;
      temperature = {
        day = 7000;
        night = 7000;
      };
      settings = {
        general.fade = 0;
      };
    };
  };
}
