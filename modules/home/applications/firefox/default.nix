{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.firefox;
in {
  options.modules.applications.firefox = {
    enable = mkEnableOption (lib.mdDoc "Enable firefox module");
  };
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.main = {
        isDefault = true;
      };
    };
  };
}
