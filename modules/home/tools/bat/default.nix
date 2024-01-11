{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.bat;
in {
  options.modules.tools.bat = {
    enable = mkEnableOption (lib.mdDoc "Enable bat module");
  };
  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };
  };
}
