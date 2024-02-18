{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.tools.tldr;
  tomlFormat = pkgs.formats.toml {};
in {
  options.configuration.tools.tldr = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable tldr module.
      tldr is a collaborative cheatsheets for console commands
      Source: https://github.com/dbrgn/tealdeer
      Documentation: https://dbrgn.github.io/tealdeer/
    '');
    implementation = mkOption {
      type = types.enum ["tealdeer" "tlrc"];
      default = "tlrc";
      description = lib.mdDoc ''
        tldr implementation to use. Should be either tealdeer or tlrc.
      '';
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf (cfg.implementation == "tealdeer") {
      programs.tealdeer = {
        enable = true;
        settings = {
          display = {
            compact = false;
            use_pager = false;
          };
          updates = {
            # Auto-updates kinda broken for me right now:
            # error sending request for url (https://tldr.sh/assets/tldr.zip):
            # error trying to connect: dns error: failed to lookup address information:
            # Name or service not known
            auto_update = false;
          };
          style = {
            command_name = {
              foreground = "cyan";
            };
            example_code = {
              foreground = "green";
              bold = true;
            };
            example_variable = {
              foreground = "green";
              bold = true;
            };
          };
        };
      };
    })

    (mkIf (cfg.implementation == "tlrc") {
      home.packages = [pkgs.tlrc];
      xdg.configFile."tlrc/config.toml" = {
        source = tomlFormat.generate "tlrc-config" {
          cache = {
            auto_update = false;
          };
          output = {
            show_title = false;
            platform_title = false;
            show_hyphens = false;
          };
          indent = {
            title = 2;
            description = 2;
            bullet = 2;
            example = 4;
          };
          style = {
            title = {
              color = "green";
              bold = true;
            };
            description = {
              color = "default";
            };
            bullet = {
              color = "default";
            };
            example = {
              color = "cyan";
            };
            url = {
              color = "cyan";
            };
            inline_code = {
              color = "yellow";
            };
            placeholder = {
              color = "green";
            };
          };
        };
      };
    })
  ]);
}
