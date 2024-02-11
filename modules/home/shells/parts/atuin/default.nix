{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.shells.parts.atuin;
in {
  options.modules.shells.parts.atuin = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable atuin module.
      Atuin replaces your existing shell history with a SQLite database, and records additional context for your commands.
      Source: https://github.com/atuinsh/atuin
      Documentation: https://docs.atuin.sh/
    '');
  };

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableBashIntegration = mkIf (config.programs.bash.enable) true;
      enableZshIntegration = mkIf (config.programs.zsh.enable) true;
      enableFishIntegration = mkIf (config.programs.fish.enable) true;
      enableNushellIntegration = mkIf (config.programs.nushell.enable) true;
      flags = [
        "--disable-up-arrow"
      ];
    };
  };
}
