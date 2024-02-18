{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.bat;
in {
  options.configuration.tools.bat = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable bat module.
      Bash is a cat(1) clone with syntax highlighting and Git integration.
      Source: https://github.com/sharkdp/bat
    '');
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "ansi";
        plain = true;
      };
    };
  };
}
