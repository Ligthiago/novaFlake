{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.fastfetch;
  userConfig = config.xdg.configHome;
in {
  options.configuration.tools.fastfetch = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable fastfetch module.
      Fastfetch is like neofetch, but much faster because written mostly in C.
      Source: https://github.com/fastfetch-cli/fastfetch
      Documentation: https://github.com/fastfetch-cli/fastfetch/wiki/Configuration
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fastfetch
    ];

    home.file = {
      "${userConfig}/fastfetch/logo.png".source = ../../../../assets/logo.png;
      "${userConfig}/fastfetch/config.jsonc".text = builtins.toJSON {
        "$schema" = "https=://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          "type" = "kitty-direct";
          "source" = "${userConfig}/fastfetch/logo.png";
          "width" = 40;
          "height" = 20;
        };
        display = {
          separator = ": ";
          percent = {
            type = "2";
          };
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
            type = "terminal";
            keyColor = "cyan";
            format = "{3}";
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
            type = "cursor";
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
