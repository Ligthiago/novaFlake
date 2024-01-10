{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.audio;
in {
  options.modules.hardware.audio = {
    enable = mkEnableOption (lib.mdDoc "Enable audio module");
  };
  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
