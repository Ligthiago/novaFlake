{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.vscode;
in {
  options.configuration.applications.vscode = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable vscode module.
      VSCode is a extensible graphical text editor.
      Source: https://code.visualstudio.com/
      Documentation: https://code.visualstudio.com/docs
    '');
    desktopName = mkOpt types.str "codium" "Name of desktop file";
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

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "VSCodium";
      genericName = "Text Editor";
      categories = ["Utility" "TextEditor"];
      type = "Application";
      terminal = false;
      icon = "vscodium";
      comment = "Full-featured graphical text editor";
      exec = "codium %F";
      settings = {
        StartupNotify = "true";
        StartupWMClass = "vscodium";
        Keywords = "GUI;Text;Code;Editor;IDE;Development;";
      };
    };
  };
}
