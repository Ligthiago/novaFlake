{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.shells.fish;
in {
  options.modules.shells.fish = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable fish module.
      Fish is a user-friendly command shell with good out-of-the-box experience.
      Source: https://github.com/fish-shell/fish-shell
      Documentation: https://fishshell.com/docs/current/index.html
    '');
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}
