{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.shells.bash;
in {
  options.modules.shells.bash = {
    enable = mkEnableOption (lib.mdDoc "Enable bash shell module");
  };
  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
    };
  };
}
