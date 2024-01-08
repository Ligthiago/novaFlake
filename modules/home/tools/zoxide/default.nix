{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.tools.zoxide;
in {
  options.modules.tools.zoxide = {
    enable = mkEnableOption (lib.mdDoc "Enable zoxide module");
  };
  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableNushellIntegration =
        if config.programs.nushell.enable
        then true
        else false;
      enableFishIntegration =
        if config.programs.fish.enable
        then true
        else false;
      enableBashIntegration =
        if config.programs.bash.enable
        then true
        else false;
      enableZshIntegration =
        if config.programs.zsh.enable
        then true
        else false;
    };
  };
}
