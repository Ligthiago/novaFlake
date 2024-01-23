{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.imagemagick;
in {
  options.modules.tools.imagemagick = {
    enable = mkEnableOption (lib.mdDoc "Enable imagemagick module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      imagemagick
    ];
  };
}
