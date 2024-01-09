{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.environment.parts.fonts;
in {
  options.modules.environment.parts.fonts = {
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
