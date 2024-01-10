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

    xdg.desktopEntries."codium" = {
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
        Keywords = "Text;Code;Editor;IDE;Development;";
      };
    };
  };
}
