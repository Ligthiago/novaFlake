{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.alacritty;
in {
  options.modules.applications.alacritty = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable alacritty module.
      Alacritty is a cross-platform, OpenGL terminal emulator. 
      Source: https://github.com/alacritty/alacritty
      Documentation: https://alacritty.org/config-alacritty.html
    '');
  };
  
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding.x = 10;
          padding.y = 10;
          dynamic_padding = false;
          decorations = "none";
          opacity = 1.0;
          class = "alacritty";
          dynamic_title = true;
        };
        font = {
          size = 10.0;
          normal = {
            family = "Iosevka Extended";
            style = "Regular";
          };
        };
        colors = let
          colors = {
            black = palette.foreground.dim;
            red = palette.accents.red;
            green = palette.accents.green;
            yellow = palette.accents.yellow;
            blue = palette.accents.blue;
            magenta = palette.accents.magenta;
            cyan = palette.accents.cyan;
            white = palette.foreground.normal;
          };
        in {
          primary = {
            background = "#1e1e1e";
            foreground = "#dddddd";
          };
          normal = colors;
          bright = colors;
        };
        cursor = {
          style = {
            shape = "Beam";
          };
        };
      };
    };
  };
}
