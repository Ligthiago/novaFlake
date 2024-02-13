{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.lazygit;
in {
  options.modules.applications.lazygit = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable lazygit module.
      Lazygit is a simple terminal UI for git commands.
      Source: https://github.com/jesseduffield/lazygit
    '');
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
