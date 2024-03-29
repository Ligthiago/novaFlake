{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.lazygit;
in {
  options.configuration.applications.lazygit = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable lazygit module.
      Lazygit is a simple terminal UI for git commands.
      Source: https://github.com/jesseduffield/lazygit
    '');
    desktopName = mkOpt types.str "lazygit" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Lazygit";
      genericName = "Git TUI";
      categories = ["Development" "Utility"];
      type = "Application";
      terminal = true;
      icon = "git";
      comment = "Terminal-based UI for git";
      exec = "lazygit";
      settings = {
        Keywords = "TUI;Git;";
      };
    };
  };
}
