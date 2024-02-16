{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.jq;
in {
  options.modules.tools.jq = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable jq module.
      jq is a lightweight and flexible command-line JSON processor.
      Source: https://github.com/jqlang/jq
      Documentation: https://jqlang.github.io/jq/manual/
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jq
    ];
  };
}
