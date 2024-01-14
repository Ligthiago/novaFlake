{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.yazi;
in {
  options.modules.applications.yazi = {
    enable = mkEnableOption (lib.mdDoc "Enable yazi module");
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
            "~/.config/yazi/plugins/rounded.lua"
          ];
        };
        manager = {
          folder_offset = [2 0 2 0];
          preview_offset = [2 1 2 1];
        };
      };
    };

    home.file.".config/yazi/plugins/".source = ./plugins;

    xdg.desktopEntries."yazi" = {
      name = "Yazi";
      genericName = "File Manager";
      categories = ["FileManager" "Utility"];
      type = "Application";
      terminal = true;
      icon = "system-file-manager";
      comment = "Terminal-based file manager";
      exec = "yazi";
      settings = {
        Keywords = "Files;Directory,Explorer,Manager";
      };
    };
  };
}