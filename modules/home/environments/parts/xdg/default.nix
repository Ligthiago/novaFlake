{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.environments.parts.xdg;
  home = config.home.homeDirectory;
in {
  options.modules.environments.parts.xdg = {
    enable = mkEnableOption (lib.mdDoc "Enable xdg module");
  };
  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = null;
        templates = null;
        publicShare = null;
        videos = "${home}/Videos";
        music = "${home}/Music";
        pictures = "${home}/Pictures";
        documents = "${home}/Documents";
        download = "${home}/Downloads";
        extraConfig = {
          XDG_MISC_DIR = "${home}/Misc";
          XDG_PROJECTS_DIR = "${home}/Projects";
          XDG_GAMES_DIR = "${home}/Games";
          XDG_LIBRARY_DIR = "${home}/Library";
          XDG_BACKUPS_DIR = "${home}/Backups";
          XDG_SCREENSHOTS_DIR = "${home}/Pictures/Screenshots";
        };
      };
      mime.enable = true;
      mimeApps = let
        editor = ["nvim.desktop"];
        terminal = ["Alacritty.desktop"];
      in {
        enable = true;
        defaultApplications = {
          "text/*" = editor;
          "text/plain" = editor;
          "x-scheme-handler/terminal" = terminal;
        };
      };
    };
    home.packages = with pkgs; [
      xdg-utils
    ];
    home.sessionVariables = {
      TERMINAL = "alacritty";
    };
  };
}
