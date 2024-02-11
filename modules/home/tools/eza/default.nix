{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.eza;
in {
  options.modules.tools.eza = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable eza module.
      Eza is a modern, maintained replacement for ls.
      Source: https://github.com/eza-community/eza
    '');
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      icons = true;
      git = true;
      extraOptions = [
        "--header"
        "--group-directories-first"
      ];
    };
  };
}
