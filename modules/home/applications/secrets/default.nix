{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.secrets;
in {
  options.configuration.applications.secrets = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable secrets module.
      Secrets is a graphical password manager.
      Source: https://gitlab.gnome.org/World/secrets
    '');
    desktopName = mkOpt types.str "org.gnome.World.Secrets" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome-secrets
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Secrets";
      genericName = "Password Manager";
      categories = ["Utility"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.World.Secrets";
      comment = "Password manager";
      exec = "secrets %U";
      settings = {
        Keywords = "Password;Encrypt;Security;";
      };
    };
  };
}
