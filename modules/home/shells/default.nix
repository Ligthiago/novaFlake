{
  options,
  config,
  lib,
  ...
}:
with lib; {
  options.modules.shells.default = mkOption {
    default = "";
    type = types.str;
  };
}
