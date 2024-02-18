{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.settings;
in {
  options.configuration.settings = {
    stateVersion = mkOpt types.str "" "Initial version to set";
  };

  config = {
    home = {
      inherit (cfg) stateVersion;
    };
  };
}
