{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.ventoy;
in {
  options.configuration.tools.ventoy = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable ventoy module.
      Ventoy is an open source tool to create bootable USB drive for ISO/WIM/IMG/VHD(x)/EFI files. 
      Source: https://github.com/ventoy/Ventoy
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ventoy
    ];
  };
}
