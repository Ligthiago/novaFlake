{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.tools.yt-dlp;
in {
  options.modules.tools.yt-dlp = {
    enable = mkEnableOption (lib.mdDoc "Enable yt-dlp module");
  };
  config = mkIf cfg.enable {
    programs.yt-dlp = {
      enable = true;
    };
  };
}
