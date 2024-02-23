{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.obsidian;
  home = config.home.homeDirectory;
in {
  options.configuration.applications.obsidian = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable obsidian module.
      Obsidian is a application for live notetaking and planing.
      Source: https://obsidian.md/
    '');
    desktopName = mkOpt types.str "obsidian" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];

    xdg.userDirs.extraConfig = {
      XDG_VAULTS_DIR = "${home}/Vaults";
    };

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Obsidian";
      genericName = "Knowledge base";
      categories = ["Office" "Documentation"];
      type = "Application";
      terminal = false;
      icon = "obsidian";
      comment = "Knowledge base and task manager";
      exec = "obsidian %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Knowledge;Vault;Tasks;";
      };
    };
  };
}
