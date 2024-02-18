{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.hyperfine;
in {
  options.configuration.tools.hyperfine = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable hyperfine module.
      Hyperfine is a command-line benchmarking tool.
      Source: https://github.com/sharkdp/hyperfine
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyperfine
    ];
  };
}
