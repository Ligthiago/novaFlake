{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nova.applications.alacritty;
in {
  options.nova.applications.alacritty = {
    enable = mkEnableOption (lib.mdDoc "Enable Alacritty, a modern GPU-powered terminal emulator");
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
        colors = {
          primary = {
            background = "#1e1e1e";
            foreground = "#dddddd";
          };
          normal = {
            black = "#343a40";
            red = "#ed333b";
            green = "#12b886";
            yellow = "#ffa348";
            blue = "#3584e4";
            magenta = "#c061cb";
            cyan = "#22b8cf";
            white = "#dddddd";
          };
          bright = {
            black = "#343a40";
            red = "#ed333b";
            green = "#12b886";
            yellow = "#ffa348";
            blue = "#3584e4";
            magenta = "#c061cb";
            cyan = "#22b8cf";
            white = "#dddddd";
          };
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
