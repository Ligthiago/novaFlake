{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.backlight;
in {
  options.modules.hardware.backlight = {
    enable = mkEnableOption (lib.mdDoc "Enable backlight module");
  };
  config = mkIf cfg.enable {
    programs.light = {
      enable = true;
    };
  };
}
