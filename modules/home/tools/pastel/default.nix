{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.pastel;
in {
  options.modules.tools.pastel = {
    enable = mkEnableOption (lib.mdDoc "Enable pastel module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pastel
    ];
  };
}
