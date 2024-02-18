{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.shells.bash;
in {
  options.configuration.shells.bash = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable bash module.
      Bash is the GNU Project's sh-compatible shell.
      Source: https://savannah.gnu.org/projects/bash/
      Documentation: https://www.gnu.org/software/bash/manual/
    '');
  };
  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
    };
  };
}
