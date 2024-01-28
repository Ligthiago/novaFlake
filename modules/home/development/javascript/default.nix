{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.javascript;
in {
  options.modules.development.javascript = {
    enable = mkEnableOption (lib.mdDoc "Enable javascript development module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bun
    ];
  };
}
