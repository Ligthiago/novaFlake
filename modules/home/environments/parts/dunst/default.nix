{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.environments.parts.dunst;
in {
  options.modules.environments.parts.dunst = {
    enable = mkEnableOption (lib.mdDoc "Enable dunst module");
  };
  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
    };
  };
}
