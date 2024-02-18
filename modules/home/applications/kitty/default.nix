{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.kitty;
in {
  options.configuration.applications.kitty = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable kitty module.
      Kitty is a cross-platform, fast, feature-rich, GPU based terminal
      Source: https://github.com/kovidgoyal/kitty
      Documentation: https://sw.kovidgoyal.net/kitty/
    '');
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
        color8 = palette.foreground.dim;
        color9 = palette.accents.red;
        color10 = palette.accents.green;
        color11 = palette.accents.yellow;
        color12 = palette.accents.blue;
        color13 = palette.accents.magenta;
        color14 = palette.accents.cyan;
        color15 = palette.foreground.normal;

        cursor_shape = "beam";

        window_padding_width = 6;
        enable_audio_bell = false;
        confirm_os_window_close = "-1";

        touch_scroll_multiplier = "2.0";
      };
    };
  };
}
