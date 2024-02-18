{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.settings.user;
in {
  options.configuration.settings.user = {
    username = mkOpt types.str "user" "Username to set";
    name = mkOpt types.str "unknown" "Real name to set";
    email = mkOpt types.str "unknown" "Email to set";
  };

  config = {
    home = rec {
      inherit (cfg) username;
      homeDirectory = "/home/${username}";
    };
  };
}
