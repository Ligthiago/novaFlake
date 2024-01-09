{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.security.firejail;
in {
  options.modules.security.firejail = {
    enable = mkEnableOption (lib.mdDoc "Enable firejail module");
  };
  config = mkIf cfg.enable {
    programs.firejail = {
      enable = true;
    };
  };
}
