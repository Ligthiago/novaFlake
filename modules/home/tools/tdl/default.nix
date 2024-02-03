{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.tdl;
in {
  options.modules.tools.tdl = {
    enable = mkEnableOption (lib.mdDoc "Enable tdl module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nova.tdl
    ];
  };
}
