{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.pastel;
in {
  options.configuration.tools.pastel = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable pastel module.
      pastel is a command-line tool to generate, analyze, convert and manipulate colors.
      Source: https://github.com/sharkdp/pastel
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pastel
    ];
  };
}
