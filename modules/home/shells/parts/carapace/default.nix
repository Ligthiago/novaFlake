{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.shells.parts.carapace;
in {
  options.configuration.shells.parts.carapace = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable carapace module.
      Carapace provides argument completion for multiple CLI commands.
      Source: https://github.com/rsteube/carapace-bin
      Documentation: https://rsteube.github.io/carapace-bin/
    '');
  };

  config = mkIf cfg.enable {
    programs.carapace = {
      enable = true;
      enableNushellIntegration = mkIf (config.programs.nushell.enable) true;
      enableFishIntegration = mkIf (config.programs.fish.enable) true;
      enableBashIntegration = mkIf (config.programs.bash.enable) true;
      enableZshIntegration = mkIf (config.programs.zsh.enable) true;
    };
  };
}
