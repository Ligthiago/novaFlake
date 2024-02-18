{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.zoxide;
in {
  options.configuration.tools.zoxide = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable zoxide module.
      zoxide is a smarter cd command, inspired by z and autojump.
      Source: https://github.com/ajeetdsouza/zoxide
    '');
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = mkIf (config.programs.bash.enable) true;
      enableZshIntegration = mkIf (config.programs.zsh.enable) true;
      enableFishIntegration = mkIf (config.programs.fish.enable) true;
      enableNushellIntegration = mkIf (config.programs.nushell.enable) true;
    };
  };
}
