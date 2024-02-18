{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.services.gammastep;
in {
  options.configuration.services.gammastep = {
    enable = mkOptEnable (lib.mdDoc "Enable gammastep module");
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
