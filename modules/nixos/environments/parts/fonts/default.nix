{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.nova.environment.parts.fonts;
in {
  options.nova.environment.parts.fonts = {
    enable = mkEnableOption (lib.mdDoc "Enable system fonts");
  };
  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      cantarell-fonts
      noto-fonts
      iosevka
      (nerdfonts.override {fonts = ["Iosevka"];})
    ];
  };
}
