{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.tldr;
in {
  options.modules.tools.tldr = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable tldr module.
      tldr is a collaborative cheatsheets for console commands
      Source: https://github.com/dbrgn/tealdeer
      Documentation: https://dbrgn.github.io/tealdeer/
    '');
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
