{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.git;
  userSettings = config.configuration.settings.user;
in {
  options.configuration.tools.git = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable git module.
      Git is a free and open source distributed version control system.
      Source: https://git-scm.com/
      Documentation: https://git-scm.com/doc
    '');
    userName = mkOption {
      type = types.str;
      default = userSettings.name;
      description = lib.mdDoc "Real name";
    };
    userEmail = mkOption {
      type = types.str;
      default = userSettings.email;
      description = lib.mdDoc "Email";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      lfs = {
        enable = true;
      };
    };
  };
}
