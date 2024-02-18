{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.ffmpeg;
in {
  options.configuration.tools.ffmpeg = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable ffmpeg module.
      FFmpeg is a collection of libraries and tools to process all types of multimedia.
      Source: https://github.com/FFmpeg/FFmpeg
      Documentation: https://ffmpeg.org/documentation.html
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpeg
    ];
  };
}
