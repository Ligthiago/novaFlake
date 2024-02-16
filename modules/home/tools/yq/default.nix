{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.yq;
in {
  options.modules.tools.yq = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable yq module.
      yq is a portable command-line YAML, JSON, XML, CSV, TOML and properties processor
      Source: https://github.com/mikefarah/yq
      Documentation: https://mikefarah.gitbook.io/yq/
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yq
    ];
  };
}
