{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.lazygit;
in {
  options.modules.applications.lazygit = {
    enable = mkEnableOption (lib.mdDoc "Enable lazygit module");
  };
  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
    xdg.desktopEntries."lazygit" = {
      name = "Lazygit";
      genericName = "Git TUI";
      categories = ["Development" "Utility"];
      type = "Application";
      terminal = true;
      icon = "git";
      comment = "Terminal-based UI for git";
      exec = "lazygit";
      settings = {
        Keywords = "Git;";
      };
    };
  };
}
