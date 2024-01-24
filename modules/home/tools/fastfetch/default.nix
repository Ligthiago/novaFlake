{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.fastfetch;
  home = config.home.homeDirectory;
in {
  options.modules.tools.fastfetch = {
    enable = mkEnableOption (lib.mdDoc "Enable fastfetch module");
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fastfetch
    ];

    home.file = {
      ".config/fastfetch/logo.png".source = ../../../../assets/logo.png;
      ".config/fastfetch/config.jsonc".text = builtins.toJSON {
        "$schema" = "https=://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          "type" = "kitty-direct";
          "source" = "${home}/.config/fastfetch/logo.png";
          "width" = 40;
          "height" = 20;
        };
        display = {
          separator = ": ";
        };
        modules = [
          {
            type = "os";
            keyColor = "cyan";
          }
          {
            type = "kernel";
            keyColor = "cyan";
          }
          {
            type = "shell";
            keyColor = "cyan";
          }
          {
            type = "wm";
            keyColor = "cyan";
          }
          {
            type = "de";
            keyColor = "cyan";
          }
          {
            type = "lm";
            keyColor = "cyan";
          }
          {
            type = "packages";
            keyColor = "cyan";
          }

          {
            type = "custom";
            format = "──────────────────────────────────";
          }

          {
            type = "host";
            keyColor = "green";
          }
          {
            type = "board";
            keyColor = "green";
          }
          {
            type = "gpu";
            keyColor = "green";
          }
          {
            type = "cpu";
            keyColor = "green";
          }
          {
            type = "Memory";
            keyColor = "green";
          }
          {
            type = "swap";
            keyColor = "green";
          }
          {
            type = "disk";
            keyColor = "green";
          }
          {
            type = "display";
            keyColor = "green";
          }
          {
            type = "battery";
            keyColor = "green";
          }

          {
            type = "custom";
            "format" = "──────────────────────────────────";
          }

          {
            type = "theme";
            keyColor = "yellow";
          }
          {
            type = "icons";
            keyColor = "yellow";
          }
          {
            type = "font";
            keyColor = "yellow";
          }
          {
            type = "terminalfont";
            keyColor = "yellow";
          }
          {
            type = "colors";
            symbol = "square";
          }
        ];
      };
    };
  };
}
