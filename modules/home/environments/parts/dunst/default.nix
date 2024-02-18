{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.environments.parts.dunst;
in {
  options.configuration.environments.parts.dunst = {
    enable = mkOptEnable (lib.mdDoc "Enable dunst module");
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
    };
  };
}
