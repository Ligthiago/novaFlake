{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.shells.parts.direnv;
in {
  options.configuration.shells.parts.direnv = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable direnv module.
      Direnv is a shell extension that can manage project environment.
      Source: https://github.com/direnv/direnv
      Documentation: https://direnv.net/
    '');
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableNushellIntegration = mkIf (config.programs.nushell.enable) true;
      enableFishIntegration = mkIf (config.programs.fish.enable) true;
      enableBashIntegration = mkIf (config.programs.bash.enable) true;
      enableZshIntegration = mkIf (config.programs.zsh.enable) true;
      nix-direnv = {
        enable = true;
      };
      config = {
        global = {
          hide_env_diff = true;
        };
      };
    };
  };
}
