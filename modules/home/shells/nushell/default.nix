{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.shells.nushell;
in {
  options.modules.shells.nushell = {
    enable = mkEnableOption (lib.mdDoc "Enable nushell module");
  };
  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
      # No permanent config for now.
    };
  };
}
