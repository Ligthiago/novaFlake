{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.environments.parts.rofi;
in {
  options.modules.environments.parts.rofi = {
    enable = mkEnableOption (lib.mdDoc "Enable rofi module");
  };
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [
        rofi-calc
        rofi-file-browser
      ];
      terminal = "${pkgs.alacritty}/bin/alacritty";
      font = "Cantarell 12";
      location = "center";
      cycle = false;
      extraConfig = {
        modi = "drun,filebrowser,calc";
        case-sensetive = false;
        show-icons = true;
        icon-theme = "Papirus";
        steal-focus = true;

        drun-categories = "";
        drun-display-format = "{name}\\n<span foreground=\"#989898\"><small>{comment}</small></span>";
        drun-match-fields = "name,generic,exec,categories,keywords";
        drun-show-actions = false;

        disable-history = false;
        sorting-method = "normal";
        max-history-size = 25;

        display-window = "Windows";
        display-run = "Runner";
        display-drun = "Launcher";
        display-keys = "Shortcuts";
        display-filebrowser = "Files";
        display-calc = "Calculator";
      };
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          background-dim = mkLiteral "#1e1e1e";
          background-normal = mkLiteral "#242424";
          background-bright = mkLiteral "#323232";
          background-exbright = mkLiteral "#464646";
          border = mkLiteral "#464646";
          foreground = mkLiteral "#dddddd";
          foreground-dim = mkLiteral "#989898";
        };

        "window" = {
          enabled = true;
          width = mkLiteral "1000px";
          height = mkLiteral "700px";
          margin = 0;
          padding = 0;
          background-color = mkLiteral "@background-dim";
          text-color = mkLiteral "@foreground";
          border = mkLiteral "1px solid";
          border-radius = mkLiteral "10px";
          border-color = mkLiteral "@border";
        };

        "mainbox" = {
          enabled = true;
          children = map mkLiteral ["inputbar" "message" "listview"];
          background-color = mkLiteral "inherit";
        };

        "inputbar" = {
          enabled = true;
          children = map mkLiteral ["textbox-logo" "input-box" "mode-switcher"];
          padding = mkLiteral "6px";
          margin = mkLiteral "0px";
          spacing = mkLiteral "6px";
          background-color = mkLiteral "@background-bright";
          border = mkLiteral "0px solid";
        };

        "input-box" = {
          enabled = true;
          children = map mkLiteral ["textbox-search" "entry"];
          margin = mkLiteral "0px";
          padding = mkLiteral "6px";
          background-color = mkLiteral "@background-exbright";
          text-color = mkLiteral "@foreground";
          border = mkLiteral "inherit";
          border-radius = mkLiteral "6px";
          orientation = mkLiteral "horizontal";
        };

        "textbox-search" = {
          enabled = true;
          expand = false;
          str = "";
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "@foreground";
        };

        "textbox-logo" = {
          enabled = true;
          expand = false;
          padding = mkLiteral "6px 30px";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "@foreground";
          border = mkLiteral "0px solid";
          str = "Rofi";
          font = "Cantarell Bold 12";
        };

        "entry" = {
          enabled = true;
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          background-color = mkLiteral "@background-exbright";
          text-color = mkLiteral "@foreground";
          border = mkLiteral "inherit";
          border-radius = mkLiteral "6px";
          placeholder = "Search";
          placeholder-color = mkLiteral "@foreground";
          cursor = mkLiteral "text";
          font-weight = mkLiteral "700";
        };

        "mode-switcher" = {
          enable = true;
          spacing = mkLiteral "10px";
          border = mkLiteral "0px solid";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          width = mkLiteral "300px";
        };

        "button" = {
          padding = mkLiteral "6px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "6px";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "@foreground";
          cursor = mkLiteral "pointer";
        };

        "button selected" = {
          background-color = mkLiteral "@background-exbright";
          text-color = mkLiteral "@foreground";
        };

        "listview" = {
          enabled = true;
          columns = 2;
          lines = 10;
          layout = mkLiteral "vertical";
          dynamic = true;
          spacing = mkLiteral "12px";

          padding = mkLiteral "12px";
          background-color = mkLiteral "@background-normal";
          text-color = mkLiteral "@foreground";
          border = mkLiteral "0px";
        };

        "scrollbar" = {
          enabled = false;
        };

        "element" = {
          enabled = true;
          spacing = mkLiteral "14px";
          padding = mkLiteral "6px 14px";
          cursor = mkLiteral "pointer";
          border = mkLiteral "1px solid";
          border-radius = mkLiteral "6px";
          border-color = mkLiteral "transparent";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
        };

        "element selected" = {
          background-color = mkLiteral "@background-bright";
          border-color = mkLiteral "@border";
        };

        "element-icon" = {
          enabled = true;
          size = mkLiteral "32px";
          cursor = mkLiteral "inherit";
          background-color = mkLiteral "transparent";
        };

        "element-text" = {
          enabled = true;
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
      };
    };
  };
}
