{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.shells.parts.atuin;
in {
  options.modules.shells.parts.atuin = {
    enable = mkEnableOption (lib.mdDoc "Enable atuin module");
  };
  config = mkIf cfg.enable {
    programs.atuin = {
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
      flags = [
        "--disable-up-arrow"
      ];
    };
  };
}
