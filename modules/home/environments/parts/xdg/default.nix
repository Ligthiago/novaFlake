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
    enable = mkOptEnable (lib.mdDoc "Enable xdg module");
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
        extraConfig = let
          pictures = config.xdg.userDirs.pictures;
        in {
          XDG_MISC_DIR = "${home}/Misc";
          XDG_PROJECTS_DIR = "${home}/Projects";
          XDG_GAMES_DIR = "${home}/Games";
          XDG_LIBRARY_DIR = "${home}/Library";
          XDG_BACKUPS_DIR = "${home}/Backups";
          XDG_SCREENSHOTS_DIR = "${pictures}/Screenshots";
          XDG_WALLPAPERS_DIR = "${pictures}/Wallpapers";
        };
      };
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = let
          defaultApps = config.modules.applications.defaultApplications;
          apps = let
            terminal =
              if defaultApps.terminal == "kitty"
              then "kitty"
              else if defaultApps.terminal == "alacritty"
              then "Alacritty"
              else "unknown";
            fileManager =
              if defaultApps.fileManager == "nautilus"
              then "org.gnome.Nautilus"
              else if defaultApps.fileManager == "yazi"
              then "yazi"
              else "unknown";
            textEditor =
              if defaultApps.textEditor == "helix"
              then "Helix"
              else if defaultApps.textEditor == "neovim"
              then "nvim"
              else if defaultApps.textEditor == "codium"
              then "codium"
              else "unknown";
            browser =
              if defaultApps.browser == "firefox"
              then "firefox"
              else "unknown";
            videoPlayer =
              if defaultApps.videoPlayer == "celluloid"
              then "io.github.celluloid_player.Celluloid"
              else "unknown";
            imageViewer =
              if defaultApps.imageViewer == "loupe"
              then "org.gnome.Loupe"
              else "unknown";
          in {
            terminal = ["${terminal}.desktop"];
            directory = ["${fileManager}.desktop"];
            pdf = ["org.gnome.Evince.desktop"];
            text = ["${textEditor}.desktop"];
            video = ["${videoPlayer}.desktop"];
            image = ["${imageViewer}.desktop"];
            archive = ["org.gnome.FileRoller.desktop"];
            browser = ["${browser}.desktop"];
          };
          mimeTypes = {
            directory = ["inode/directory"];
            terminal = ["x-scheme-handler/terminal"];
            text = [
              "text/plain"
            ];
            browser = [
              "text/html"
            ];
            video = [
              "video/avi"
              "video/mpeg"
              "video/x-matroska"
              "video/quicktime"
              "video/mp4"
              "video/ogg"
              "video/webm"
              "video/mp2t"
            ];
            image = [
              "image/png"
              "image/jpg"
              "image/jpeg"
              "image/gif"
              "image/jxl"
              "image/tiff"
              "image/svg+xml"
              "image/x-dwg"
              "image/webp"
              "image/bmp"
            ];
            pdf = ["application/pdf"];
            archive = [
              "application/bzip2"
              "application/gzip"
              "application/vnd.rar"
              "application/x-7z-compressed"
              "application/x-7z-compressed-tar"
              "application/x-bzip"
              "application/x-bzip-compressed-tar"
              "application/x-compress"
              "application/x-compressed-tar"
              "application/x-cpio"
              "application/x-gzip"
              "application/x-lha"
              "application/x-lzip"
              "application/x-lzip-compressed-tar"
              "application/x-lzma"
              "application/x-lzma-compressed-tar"
              "application/x-tar"
              "application/x-tarz"
              "application/x-xar"
              "application/x-xz"
              "application/x-xz-compressed-tar"
              "application/zip"
            ];
          };
        in
          builtins.listToAttrs (flatten (mapAttrsToList (key: types:
            map (type: nameValuePair type (apps."${key}")) types)
          mimeTypes));
      };
    };

    home.packages = with pkgs; [
      xdg-utils
    ];

    home.sessionVariables = {
      TERMINAL = "kitty";
    };
  };
}
