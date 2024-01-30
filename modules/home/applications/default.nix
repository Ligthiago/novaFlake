{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.applications.browsers;
in {
  options.modules.applications.defaultApplications = {
    terminal = mkOption {
      default = "";
      type = types.str;
    };
    fileManager = mkOption {
      default = "";
      type = types.str;
    };
    textEditor = mkOption {
      default = "";
      type = types.str;
    };
    browser = mkOption {
      default = "";
      type = types.str;
    };
    videoPlayer = mkOption {
      default = "";
      type = types.str;
    };
    audioPlayer = mkOption {
      default = "";
      type = types.str;
    };
    imageViewer = mkOption {
      default = "";
      type = types.str;
    };
    pdfViewer = mkOption {
      default = "";
      type = types.str;
    };
    archiveManager = mkOption {
      default = "";
      type = types.str;
    };
  };
}
