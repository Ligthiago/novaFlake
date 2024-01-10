{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.environments.parts.eww;
in {
  options.modules.environments.parts.eww = {
    enable = mkEnableOption (lib.mdDoc "Enable eww module");
  };
  config = mkIf cfg.enable {
    programs.eww = {
      enable = true;
      package = pkgs.eww-wayland;
      configDir = ./config;
    };
  };
}
