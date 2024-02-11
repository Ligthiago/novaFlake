{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.secrets;
in {
  options.modules.applications.secrets = {
      enable = mkOptEnable (lib.mdDoc ''
      Enable secrets module.
      Secrets is a graphical password manager.
      Source: https://gitlab.gnome.org/World/secrets
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome-secrets
    ];

     xdg.desktopEntries."org.gnome.World.Secrets" = {
       name = "Secrets";
       genericName = "Password Manager";
       categories = ["Utility"];
       type = "Application";
       terminal = false;
       icon = "org.gnome.World.Secrets";
       comment = "Password manager";
       exec = "secrets %U";
       settings = {
         Keywords = "Password;Encrypt,Security;";
      };
     };
  };
}
