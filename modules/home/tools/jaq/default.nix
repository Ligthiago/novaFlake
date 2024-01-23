{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.jq;
in {
  options.modules.tools.jq = {
    enable = mkEnableOption (lib.mdDoc "Enable jq module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jaq
      jq
    ];
  };
}
