{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.environments.parts.hyprlock;
in {
  options.configuration.environments.parts.hyprlock = {
    enable = mkOptEnable (lib.mdDoc "Enable hyprlock module");
  };

  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
      general = {
        disable_loading_bar = false;
      };
      backgrounds = [
        {
          path = "${config.xdg.userDirs.extraConfig.XDG_WALLPAPERS_DIR}/DarkNoise06.png";
          color = "rgb(161616)";
        }
      ];
      input-fields = [
        {
          size = {
            width = 300;
            height = 36;
          };
          position = {
            x = 0;
            y = 0;
          };
          halign = "center";
          valign = "center";
          rounding = 6;
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.4;
          dots_center = true;
          dots_rounding = -1;
          hide_input = false;
          shadow_size = 0;
          outer_color = "rgb(424242)";
          inner_color = "rgb(424242)";
          font_color = "rgb(dddddd)";
          fade_on_empty = false;
          placeholder_text = "<span foreground='##dddddd' font_family='Cantarell' font='Sans Bold 12'>Enter Password</span>";
        }
      ];
      labels = [
        {
          position = {
            x = 0;
            y = 80;
          };
          text = "$TIME";
          color = "rgb(dddddd)";
          halign = "center";
          valign = "center";
          font_size = 36;
          font_family = "Cantarell";
        }
        {
          position = {
            x = 180;
            y = 0;
          };
          text = "$LAYOUT[EN,RU,...]";
          color = "rgb(dddddd)";
          halign = "center";
          valign = "center";
          font_size = 12;
          font_family = "Cantarell";
        }
      ];
    };
  };
}
