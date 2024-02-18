{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.nova; let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  cfg = config.configuration.environments.parts.swayidle;
in {
  options.configuration.environments.parts.swayidle = {
    enable = mkOptEnable (lib.mdDoc "Enable swayidle module");
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
