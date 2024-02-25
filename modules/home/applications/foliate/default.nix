{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.foliate;
in {
  options.configuration.applications.foliate = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable foliate module.
      Foliate is a simple and modern eBook reader
      Source: https://github.com/johnfactotum/foliate
    '');
    desktopName = mkOpt types.str "com.github.johnfactotum.Foliate" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      foliate
    ];

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Foliate";
      genericName = "E-Book Reader";
      categories = ["Office" "Viewer"];
      type = "Application";
      terminal = false;
      icon = "com.github.johnfactotum.Foliate";
      comment = "Ebook Reader";
      exec = "foliate %U";
      settings = {
        StartupNotify = "true";
        Keywords = "Ebook;Book;Reader;EPUB;Viewer;";
      };
    };
  };
}
