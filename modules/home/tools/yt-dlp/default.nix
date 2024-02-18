{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.yt-dlp;
in {
  options.configuration.tools.yt-dlp = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable yt-dlp module.
      yt-dlp is a command-line benchmarking tool.
      Source: https://github.com/yt-dlp/yt-dlp
    '');
  };

  config = mkIf cfg.enable {
    programs.yt-dlp = {
      enable = true;
    };
  };
}
