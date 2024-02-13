{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.environments.parts.ags;
in {
  options.modules.environments.parts.ags = {
    enable = mkOptEnable (lib.mdDoc "Enable xdg module");
  };

  config = mkIf cfg.enable {
    programs.ags = {
      enable = true;
    };

    home.packages = with pkgs; [
      libdbusmenu-gtk3
      dart-sass
      sassc
    ];
  };
}
