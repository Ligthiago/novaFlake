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
        nvim = ["nvim.desktop"];
        alacritty = ["Alacritty.desktop"];
        celluloid = ["io.github.celluloid_player.Celluloid.desktop"];
        loupe = ["org.gnome.Loupe.desktop"];
      in {
        enable = true;
        defaultApplications = {
          "text/*" = nvim;
          "text/plain" = nvim;
          "x-scheme-handler/terminal" = alacritty;
          "video/*" = celluloid;
          "video/mp4" = celluloid;
          "video/webm" = celluloid;
          "image/jpeg" = loupe;
          "image/png" = loupe;
          "image/gif" = loupe;
          "image/jxl" = loupe;
          "image/tiff" = loupe;
          "image/avif" = loupe;
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
