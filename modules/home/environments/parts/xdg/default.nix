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
  applications = config.configuration.applications;
  tools = config.configuration.tools;
in {
  options.configuration.environments.parts.xdg = {
    enable = mkOptEnable (lib.mdDoc "Enable xdg module");
  };

  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      userDirs = rec {
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
          XDG_SCREENSHOTS_DIR = "${pictures}/Screenshots";
          XDG_WALLPAPERS_DIR = "${pictures}/Wallpapers";
          XDG_VAULTS_DIR = mkIf (applications.obsidian.enable) "${home}/Vaults";
          XDG_GALLERYDL_DIR = mkIf (tools.gallery-dl.enable) "${download}/Gallery-dl";
        };
      };
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = let
          defaultApps = config.configuration.settings.defaults;
          apps = {
            terminal = ["${applications."${defaultApps.terminal}".desktopName}.desktop"];
            directory = ["${applications."${defaultApps.fileManager}".desktopName}.desktop"];
            pdf = ["${applications."${defaultApps.pdfViewer}".desktopName}.desktop"];
            text = ["${applications."${defaultApps.textEditor}".desktopName}.desktop"];
            video = ["${applications."${defaultApps.videoPlayer}".desktopName}.desktop"];
            image = ["${applications."${defaultApps.imageViewer}".desktopName}.desktop"];
            audio = ["${applications."${defaultApps.audioPlayer}".desktopName}.desktop"];
            archive = ["${applications."${defaultApps.archiveManager}".desktopName}.desktop"];
            browser = ["${applications."${defaultApps.browser}".desktopName}.desktop"];
            office = ["${applications."${defaultApps.office}".desktopName}.desktop"];
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
            office = [
              "application/vnd.oasis.opendocument.text"
              "application/msword"
              "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
              "application/rtf"

              "application/vnd.oasis.opendocument.presentation"
              "application/vnd.ms-powerpoint"
              "application/vnd.openxmlformats-officedocument.presentationml.presentation"

              "application/vnd.oasis.opendocument.formula"

              "application/vnd.oasis.opendocument.base"

              "application/vnd.oasis.opendocument.spreadsheet"
              "application/vnd.ms-excel"
              "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

              "application/vnd.oasis.opendocument.graphics"
              "application/vnd.visio"
            ];
          };
        in
          builtins.listToAttrs (flatten (mapAttrsToList (key: types:
            map (type: nameValuePair type (apps."${key}")) types)
          mimeTypes));
      };
    };

    # Apply custom folder icons
    home.activation = let
      iconPath = "file://${home}/.nix-profile/share/icons/Papirus/128x128/places";
      dirs = config.xdg.userDirs.extraConfig;
    in {
      applyCustomIcons =
        ''
          mkdir -p ${dirs.XDG_MISC_DIR} ${dirs.XDG_PROJECTS_DIR} ${dirs.XDG_BACKUPS_DIR} ${dirs.XDG_GAMES_DIR} \
          ${dirs.XDG_LIBRARY_DIR} ${dirs.XDG_SCREENSHOTS_DIR} ${dirs.XDG_WALLPAPERS_DIR} ${dirs.XDG_WALLPAPERS_DIR}

          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_MISC_DIR} metadata::custom-icon ${iconPath}/folder-activities.svg
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_PROJECTS_DIR} metadata::custom-icon ${iconPath}/folder-projects.svg
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_BACKUPS_DIR} metadata::custom-icon ${iconPath}/folder-backup.svg
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_GAMES_DIR} metadata::custom-icon ${iconPath}/folder-games.svg
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_LIBRARY_DIR} metadata::custom-icon ${iconPath}/folder-books.svg
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_SCREENSHOTS_DIR} metadata::custom-icon ${iconPath}/folder-photo.svg
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_WALLPAPERS_DIR} metadata::custom-icon ${iconPath}/folder-pictures.svg
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_WALLPAPERS_DIR} metadata::custom-icon ${iconPath}/folder-pictures.svg
        ''
        + lib.strings.concatStrings (lib.optional applications.obsidian.enable ''
          mkdir -p ${dirs.XDG_VAULTS_DIR}
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_VAULTS_DIR} metadata::custom-icon ${iconPath}/folder-obsidian.svg
        '')
          + lib.strings.concatStrings (lib.optional tools.gallery-dl.enable ''
          mkdir -p ${dirs.XDG_GALLERYDL_DIR}
          PATH="${config.home.path}/bin:$PATH" $DRY_RUN_CMD gio set ${dirs.XDG_GALLERYDL_DIR} metadata::custom-icon ${iconPath}/folder-downloads.svg
        '');
    };

    home.packages = with pkgs; [
      xdg-utils
    ];

    home.sessionVariables = {
      TERMINAL = config.configuration.settings.defaults.terminal;
    };
  };
}
