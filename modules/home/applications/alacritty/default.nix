{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.alacritty;
in {
  options.configuration.applications.alacritty = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable alacritty module.
      Alacritty is a cross-platform, OpenGL terminal emulator.
      Source: https://github.com/alacritty/alacritty
      Documentation: https://alacritty.org/config-alacritty.html
    '');
    desktopName = mkOpt types.str "Alacritty" "Name of desktop file";
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

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Alacritty";
      genericName = "Terminal Emulator";
      categories = ["System" "TerminalEmulator"];
      type = "Application";
      terminal = false;
      icon = "Alacritty";
      comment = "Fast and minimalistic terminal emulator";
      exec = "alacritty";
      settings = {
        StartupNotify = "true";
        Keywords = "Terminal;Emulator;Commands;CLI;";
        StartupWMClass = "Alacritty";
      };
    };
  };
}
