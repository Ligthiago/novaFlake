{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.helvum;
in {
  options.configuration.applications.helvum = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable helvum module.
      Helvum is a is a patchbay for pipewire
      Source: https://gitlab.freedesktop.org/pipewire/helvum
    '');
    desktopName = mkOpt types.str "org.pipewire.Helvum" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      helvum
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Helvum";
      genericName = "Patchbay";
      categories = ["Audio" "Video" "AudioVideo" "Settings"];
      type = "Application";
      terminal = false;
      icon = "org.pipewire.Helvum";
      comment = "Patchbay utility for Pipewire";
      exec = "helvum";
      settings = {
        StartupNotify = "true";
        Keywords = "Pipewire;Control;Output;Wire;Sound;";
      };
    };
  };
}
