{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.gallery-dl;
in {
  options.modules.tools.gallery-dl = {
    enable = mkEnableOption (lib.mdDoc "Enable gallery-dl module");
  };
  config = mkIf cfg.enable {
    programs.gallery-dl = {
      enable = true;
    };
  };
}
