{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.shells.nushell;
in {
  options.modules.shells.nushell = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable nushell module.
      Nushell is a modern command shell, in which all data is structured.
      Source: https://github.com/nushell/nushell
      Documentation: https://www.nushell.sh/book/
    '');
  };

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
    };
  };
}
