{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.imagemagick;
in {
  options.modules.tools.imagemagick = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable tdl module.
      ImageMagick includes a command-line tool for executing complex image processing tasks.
      Source: https://github.com/imagemagick/imagemagick
      Documentation: https://imagemagick.org/
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      imagemagick
    ];
  };
}
