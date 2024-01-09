{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.gvfs;
in {
  options.modules.services.gvfs = {
    enable = mkEnableOption (lib.mdDoc "Enable gvfs module");
  };
  config = mkIf cfg.enable {
    services.gvfs = {
      enable = true;
    };
  };
}
