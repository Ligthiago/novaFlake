{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.environments.parts.eww;
in {
  options.modules.environments.parts.eww = {
    enable = mkOptEnable (lib.mdDoc "Enable eww module");
  };
  
  config = mkIf cfg.enable {
    programs.eww = {
      enable = true;
      package = pkgs.eww-wayland;
      configDir = ./config;
    };
  };
}
