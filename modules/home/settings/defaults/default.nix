{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; {
  options.configuration.settings.defaults = {
    terminal = mkOpt types.str "none" "Default terminal to set";
    fileManager = mkOpt types.str "none" "Default file manager to set";
    textEditor = mkOpt types.str "none" "Default text editor to set";
    browser = mkOpt types.str "none" "Default browser to set";
    videoPlayer = mkOpt types.str "none" "Default video player to set";
    audioPlayer = mkOpt types.str "none" "Default audio player to set";
    imageViewer = mkOpt types.str "none" "Default image viewer to set";
    pdfViewer = mkOpt types.str "none" "Default pdf viewer to set";
    archiveManager = mkOpt types.str "none" "Default achive manager to set";
    resourceMonitor = mkOpt types.str "none" "Default resource monitor to set";
    shell = mkOpt types.str "none" "Default command shell to set";
    office = mkOpt types.str "none" "Default office suit to set";
  };
}
