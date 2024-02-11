{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.shells.bash;
in {
  options.modules.shells.bash = {
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
