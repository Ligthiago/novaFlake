{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.pet;
in {
  options.modules.tools.pet = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable pet module.
      pet  is a simple command-line snippet manager.
      Source: https://github.com/knqyf263/pet
    '');
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
