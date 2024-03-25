{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.helix;
in {
  options.configuration.applications.helix = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable helix module.
      Helix is a post-modern modal text editor.
      Source: https://github.com/helix-editor/helix
      Documentation: https://docs.helix-editor.com/
    '');
    desktopName = mkOpt types.str "Helix" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        theme = "adwaita-dark";
        editor = {
          line-number = "relative";
          cursor-shape = {
            normal = "bar";
            insert = "bar";
            select = "bar";
          };
          lsp = {
            display-inlay-hints = true;
          };
        };
      };
    };

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Helix";
      genericName = "Text Editor";
      categories = ["Utility" "TextEditor"];
      type = "Application";
      terminal = true;
      icon = "helix";
      comment = "Text editor for terminal";
      exec = "hx %F";
      settings = {
        StartupNotify = "true";
        Keywords = "TUI;Text;Editor;Terminal;TUI;Code;";
      };
    };
  };
}
