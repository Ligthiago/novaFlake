{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.kitty;
in {
  options.modules.applications.kitty = {
    enable = mkEnableOption (lib.mdDoc "Enable kitty module");
  };
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        font_family = "Iosevka Extended";
        bold_font = "Iosevka Bold Extended";
        italic_font = "Iosevka Extended Italic";
        bold_italic_font = "Iosevka Bold Extended Italic";
        font_size = "10.0";

        foreground = "#dddddd";
        background = "#1e1e1e";
        color0 = palette.foreground.dim;
        color1 = palette.accents.red;
        color2 = palette.accents.green;
        color3 = palette.accents.yellow;
        color4 = palette.accents.blue;
        color5 = palette.accents.magenta;
        color6 = palette.accents.cyan;
        color7 = palette.foreground.normal;

        cursor_shape = "beam";

        window_padding_width = 6;
        enable_audio_bell = false;
        confirm_os_window_close = -1;

        touch_scroll_multiplier = "2.0";
      };
    };
  };
}
