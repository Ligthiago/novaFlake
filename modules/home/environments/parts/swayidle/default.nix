{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  cfg = config.modules.environments.parts.swayidle;
in {
  options.modules.environments.parts.swayidle = {
    enable = mkEnableOption (lib.mdDoc "Enable vnstat module");
  };
  config = mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      timeouts = [
        {
          command = "${hyprland}/bin/hyprctl dispatch exec [fullscreen] ${pkgs.alacritty}/bin/alacritty";
          resumeCommand = "${hyprland}/bin/hyprctl dispatch killactive";
          timeout = 10;
        }
      ];
    };
  };
}
