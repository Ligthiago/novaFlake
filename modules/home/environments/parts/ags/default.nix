{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.environments.parts.ags;
in {
  options.modules.environments.parts.ags = {
    enable = mkEnableOption (lib.mdDoc "Enable ags module");
  };
  config = mkIf cfg.enable {
    programs.ags = {
      enable = true;
    };
  };
}
