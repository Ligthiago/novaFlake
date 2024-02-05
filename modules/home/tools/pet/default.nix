{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.pet;
in {
  options.modules.tools.pet = {
    enable = mkEnableOption (lib.mdDoc "Enable pet module");
  };
  config = mkIf cfg.enable {
    programs.pet = {
      enable = true;
      selectcmdPackage = pkgs.fzf;
      settings = {
        general = {
          cmd = ["${config.modules.shells.default}" "-c"];
        };
      };
    };
  };
}
