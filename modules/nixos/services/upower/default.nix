{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.upower;
in {
  options.modules.services.upower = {
    enable = mkEnableOption (lib.mdDoc "Enable upower module");
  };
  config = mkIf cfg.enable {
    services.upower = {
      enable = true;
    };
  };
}
