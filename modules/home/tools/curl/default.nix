{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.curl;
in {
  options.configuration.tools.curl = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable curlie module.
      Curlie is a frontend to curl that adds the ease of use of httpie.
      Source: https://github.com/rs/curlie
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      curlie
    ];
  };
}
