{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.lutris;
in {
  options.configuration.applications.lutris = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable lutris module.
      Lutris is a video game preservation platform.
      Source: https://github.com/lutris/lutris
    '');
    desktopName = mkOpt types.str "net.lutris.Lutris" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lutris
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Lutris";
      genericName = "Game Launcher";
      categories = ["Game"];
      type = "Application";
      terminal = false;
      icon = "lutris";
      comment = "Video game preservation platform";
      exec = "lutris %U";
      settings = {
        StartupNotify = "true";
        Keywords = "GUI;Gaming;Wine;Library;Emulation;";
      };
    };
  };
}
