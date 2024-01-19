{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.helix;
in {
  options.modules.applications.helix = {
    enable = mkEnableOption (lib.mdDoc "Enable helix module");
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
