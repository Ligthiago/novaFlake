{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.identity;
in {
  options.configuration.applications.identity = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable identity module.
      Identity is a utility for comparing multiple versions of an image or video
      Source: https://gitlab.gnome.org/YaLTeR/identity
    '');
    desktopName = mkOpt types.str "org.gnome.gitlab.YaLTeR.Identity" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      identity
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Identity";
      genericName = "Image/Video comparing tool";
      categories = ["Viewer" "Video" "AudioVideo" "Graphics"];
      type = "Application";
      terminal = false;
      icon = "org.gnome.gitlab.YaLTeR.Identity";
      comment = "Utility for comparing multiple versions of an image or video";
      exec = "identity %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Image;Video;Difference;Compare;";
      };
    };
  };
}
