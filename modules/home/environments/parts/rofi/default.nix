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
  cfg = config.configuration.environments.parts.rofi;
in {
  options.configuration.environments.parts.rofi = {
    enable = mkOptEnable (lib.mdDoc "Enable rofi module");
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      # terminal = "${pkgs.alacritty}/bin/alacritty";
      font = "Cantarell 12";
      location = "center";
      cycle = false;
      extraConfig = {
        cache-dir = "${config.xdg.dataHome}/rofi/history/";
        modi = "drun";
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
          width = mkLiteral "60%";
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
          children = map mkLiteral ["textbox-logo" "input-box" "textbox-logo2"];
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
          padding = mkLiteral "6px 50px";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "@foreground";
          border = mkLiteral "0px solid";
          str = "Applications";
          font = "Cantarell Bold 12";
        };

        "textbox-logo2" = {
          enabled = true;
          expand = false;
          padding = mkLiteral "6px 50px";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "transparent";
          border = mkLiteral "0px solid";
          str = "Applications";
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
          padding = mkLiteral "0px 0px 0px 30px";
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
          padding = mkLiteral "8px 14px";
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
    # Fixed and reproducible history. Rofi can't change read-only file, just give a warning.
    home.file."${config.xdg.dataHome}/rofi/history/rofi3.druncache".text = ''
      99 kitty.desktop
      98 org.gnome.Nautilus.desktop
      97 firefox.desktop
      96 codium.desktop
      95 nvim.desktop
      94 com.obsproject.Studio.desktop
      93 org.gnome.Evince.desktop
      92 io.github.celluloid_player.Celluloid.desktop
      91 org.gnome.Loupe.desktop
      90 org.gnome.World.Secrets.desktop
      89 yarr.desktop
      88 io.gitlab.news_flash.NewsFlash.desktop
      80 btop.desktop
      79 stui.desktop
      78 lazygit.desktop
      77 yazi.desktop
      76 musikcube.desktop
      70 amdgpu_top.desktop
      69 Alacritty.desktop
    '';
  };
}
