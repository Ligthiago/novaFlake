{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.tools.git;
in {
  options.modules.tools.git = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable git module.
      Git is a free and open source distributed version control system.
      Source: https://git-scm.com/
      Documentation: https://git-scm.com/doc
    '');
    userName = mkOpt types.str "John Doe" "Name of a user";
    userEmail = mkOpt types.str "johndoe@mail.com" "Email of a user";
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
