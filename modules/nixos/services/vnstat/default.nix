{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.vnstat;
in {
  options.modules.services.vnstat = {
    enable = mkEnableOption (lib.mdDoc "Enable vnstat module");
  };
  config = mkIf cfg.enable {
    services.vnstat = {
      enable = true;
    };
  };
}
