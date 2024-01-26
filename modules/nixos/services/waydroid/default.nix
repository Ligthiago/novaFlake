{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.waydroid;
in {
  options.modules.services.waydroid = {
    enable = mkEnableOption (lib.mdDoc "Enable waydroid module");
  };
  config = mkIf cfg.enable {
    virtualisation.waydroid.enable = true;
  };
}
