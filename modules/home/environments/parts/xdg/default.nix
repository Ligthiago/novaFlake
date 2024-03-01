{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.environments.parts.xdg;
  home = config.home.homeDirectory;
in {
  options.configuration.environments.parts.xdg = {
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
          defaultApps = config.configuration.settings.defaults;
          apps = {
            terminal = ["${config.configuration.applications."${defaultApps.terminal}".desktopName}.desktop"];
            directory = ["${config.configuration.applications."${defaultApps.fileManager}".desktopName}.desktop"];
            pdf = ["${config.configuration.applications."${defaultApps.pdfViewer}".desktopName}.desktop"];
            text = ["${config.configuration.applications."${defaultApps.textEditor}".desktopName}.desktop"];
            video = ["${config.configuration.applications."${defaultApps.videoPlayer}".desktopName}.desktop"];
            image = ["${config.configuration.applications."${defaultApps.imageViewer}".desktopName}.desktop"];
            audio = ["${config.configuration.applications."${defaultApps.audioPlayer}".desktopName}.desktop"];
            archive = ["${config.configuration.applications."${defaultApps.archiveManager}".desktopName}.desktop"];
            browser = ["${config.configuration.applications."${defaultApps.browser}".desktopName}.desktop"];
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
            audio = [
              "audio/mpeg"
              "audio/wav"
              "audio/x-aac"
              "audio/x-aiff"
              "audio/x-ape"
              "audio/x-flac"
              "audio/x-m4a"
              "audio/x-m4b"
              "audio/x-mp1"
              "audio/x-mp2"
              "audio/x-mp3"
              "audio/x-mpg"
              "audio/x-mpeg"
              "audio/x-mpegurl"
              "audio/x-opus+ogg"
              "audio/x-pn-aiff"
              "audio/x-pn-au"
              "audio/x-pn-wav"
              "audio/x-speex"
              "audio/x-vorbis"
              "audio/x-vorbis+ogg"
              "audio/x-wavpack"
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
