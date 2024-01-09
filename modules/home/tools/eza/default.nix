{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.tools.eza;
in {
  options.modules.tools.eza = {
    enable = mkEnableOption (lib.mdDoc "Enable eza module");
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
