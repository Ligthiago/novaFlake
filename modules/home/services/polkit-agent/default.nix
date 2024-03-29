{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.services.polkit-agent;
in {
  options.configuration.services.polkit-agent = {
    enable = mkOptEnable (lib.mdDoc "Enable polkit-agent module");
  };
  config = mkIf cfg.enable {
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit.Description = "polkit-gnome-authentication-agent-1";

      Install = {
        WantedBy = ["graphical-session.target"];
        Wants = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
