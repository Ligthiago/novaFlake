{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.environments.parts.hypridle;
in {
  options.configuration.environments.parts.hypridle = {
    enable = mkOptEnable (lib.mdDoc "Enable hypridle module");
  };

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      package = pkgs.hypridle;
      lockCmd = "${getExe config.programs.hyprlock.package}";
      afterSleepCmd = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms on";
      listeners = [
        {
          timeout = 600;
          onTimeout = "${getExe config.programs.hyprlock.package}";
        }
        {
          timeout = 1200;
          onTimeout = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms off";
          onResume = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms on";
        }
      ];
    };
  };
}
