{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.helix;
in {
  options.modules.applications.helix = {
     enable = mkOptEnable (lib.mdDoc ''
      Enable helix module.
      Helix is a post-modern modal text editor. 
      Source: https://github.com/helix-editor/helix
      Documentation: https://docs.helix-editor.com/
    '');
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
  };
}
