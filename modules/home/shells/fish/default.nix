{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.shells.fish;
in {
  options.modules.shells.fish = {
    enable = mkEnableOption (lib.mdDoc "Enable fish module");
  };
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}
