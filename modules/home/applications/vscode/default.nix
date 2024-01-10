{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.vscode;
in {
  options.modules.applications.vscode = {
    enable = mkEnableOption (lib.mdDoc "Enable vscode module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nil
      alejandra
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = true; 
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        piousdeer.adwaita-theme
      ];
      userSettings = {
        "window.titleBarStyle" = "custom";
        "editor.minimap.enabled" = false;
        "editor.fontSize" = 13;
        "editor.fontFamily" = "Iosevka Extended";
        "workbench.activityBar.location" = "hidden";
        "workbench.colorTheme" = "Adwaita Dark & default syntax highlighting";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = ["alejandra"];
            };
          };
        };
      };
    };

    #    xdg.desktopEntries."io.github.celluloid_player.Celluloid" = {
    #      name = "Celluloid";
    #      genericName = "Media Player";
    #      categories = ["Audio" "Video"];
    #      type = "Application";
    #      terminal = false;
    #      icon = "io.github.celluloid_player.Celluloid";
    #      comment = "Mpv-based video player";
    #      exec = "firejail celluloid %U";
    #      settings = {
    #        Keywords = "Audio;Video;Media;Player";
    #        DBusActivatable = "true";
    #      };
    #    };
  };
}
