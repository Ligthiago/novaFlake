{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.hyperfine;
in {
  options.modules.tools.hyperfine = {
    enable = mkEnableOption (lib.mdDoc "Enable hyperfine module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyperfine
    ];
  };
}
