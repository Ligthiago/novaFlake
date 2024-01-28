{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.curl;
in {
  options.modules.tools.curl = {
    enable = mkEnableOption (lib.mdDoc "Enable curl module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      curlie
    ];
  };
}
