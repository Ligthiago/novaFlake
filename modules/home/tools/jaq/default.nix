{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.jaq;
in {
  options.modules.tools.jaq = {
    enable = mkEnableOption (lib.mdDoc "Enable jaq module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jaq
    ];
  };
}
