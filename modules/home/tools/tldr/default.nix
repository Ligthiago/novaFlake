{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.tldr;
in {
  options.modules.tools.tldr = {
    enable = mkEnableOption (lib.mdDoc "Enable tldr module");
  };
  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = false;
        };
        updates = {
          auto_update = true;
        };
        style = {
          command_name = {
            foreground = "cyan";
          };
          example_code = {
            foreground = "green";
            bold = true;
          };
          example_variable = {
            foreground = "green";
            bold = true;
          };
        };
      };
    };
  };
}
