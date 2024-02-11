{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.gallery-dl;
in {
  options.modules.tools.gallery-dl = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable gallery-dl module.
      gallery-dl is a command-line program to download image galleries and collections from several image hosting sites.
      Source: https://github.com/mikf/gallery-dl
    '');
  };

  config = mkIf cfg.enable {
    programs.gallery-dl = {
      enable = true;
    };
  };
}
