{
  options,
  config,
  lib,
  ...
}:
with lib; {
  options.configuration.shells.default = mkOption {
    default = "";
    type = types.str;
  };
}
