{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.environments.parts.dunst;
in {
  options.modules.environments.parts.dunst = {
    enable = mkOptEnable (lib.mdDoc "Enable dunst module");
  };
  
  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
    };
  };
}
