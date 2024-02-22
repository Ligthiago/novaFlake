{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.yazi;
in {
  options.configuration.applications.yazi = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable yazi module.
      Yazi is a terminal file manager.
      Source: https://yazi-rs.github.io/docs/configuration/overview
    '');
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableBashIntegration = mkIf (config.programs.bash.enable) true;
      enableZshIntegration = mkIf (config.programs.zsh.enable) true;
      enableFishIntegration = mkIf (config.programs.fish.enable) true;
      enableNushellIntegration = true;
      settings = {
        plugins = {
          preload = [
            "${config.xdg.configHome}/yazi/plugins/rounded.lua"
          ];
        };
        manager = {
          folder_offset = [2 0 2 0];
          preview_offset = [2 1 2 1];
        };
      };
    };

    home.file."${config.xdg.configHome}/yazi/plugins/".source = ./plugins;

    xdg.desktopEntries."yazi" = {
      name = "Yazi";
      genericName = "File Manager";
      categories = ["FileManager" "Utility"];
      type = "Application";
      terminal = true;
      icon = "system-file-manager";
      comment = "File manager for terminal";
      exec = "yazi";
      settings = {
        Keywords = "Files;Directory,Explorer,Manager";
      };
    };
  };
}
