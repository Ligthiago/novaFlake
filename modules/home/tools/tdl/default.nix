{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.tdl;
in {
  options.modules.tools.tdl = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable tdl module.
      tdl is a set of tools for Telegram, such as parser and downloader.
      Source: https://github.com/iyear/tdl
      Documentation: https://docs.iyear.me/tdl/
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tdl
    ];
  };
}
