{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.pget;
in {
  options.modules.tools.pget = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable pget module.
      pget is a fast, resumable file download client 
      Source: https://github.com/Code-Hex/pget
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pget
    ];
  };
}
