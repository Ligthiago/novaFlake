{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.applications.neovim;
in {
  options.modules.applications.neovim = {
    enable = mkEnableOption (lib.mdDoc "Enable neovim module");
  };
  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      plugins = {
        nix.enable = true; 
      };
    };
  };
}
