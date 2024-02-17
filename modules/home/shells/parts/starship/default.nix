{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.shells.parts.starship;
in {
  options.modules.shells.parts.starship = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable starship module.
      Starship is a minimal, blazing-fast, and infinitely customizable prompt for any shell.
      Source: https://github.com/starship/starship
      Documentation: https://starship.rs/config/
    '');
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableNushellIntegration = mkIf (config.programs.nushell.enable) true;
      enableFishIntegration = mkIf (config.programs.fish.enable) true;
      enableBashIntegration = mkIf (config.programs.bash.enable) true;
      enableZshIntegration = mkIf (config.programs.zsh.enable) true;
      enableIonIntegration = mkIf (config.programs.ion.enable) true;
      settings = {
        format = ''
          $shell$directory$git_branch$nix_shell$lua$bun$nodejs$python$rust$golang$status
          [❱ ](green)
        '';
        add_newline = false;
        follow_symlinks = false;

        shell = {
          disabled = false;
          format = "[ $indicator](bold green) ";
          bash_indicator = "Bash";
          fish_indicator = "Fish";
          zsh_indicator = "Zsh";
          powershell_indicator = "Powershell";
          ion_indicator = "Ion";
          tcsh_indicator = "Tcsh";
          xonsh_indicator = "Xonsh";
          elvish_indicator = "Elvish";
          nu_indicator = "Nushell";
          unknown_indicator = "Unknown shell";
        };

        directory = {
          format = "in [ $path](bold cyan)[$read_only](red) ";
          repo_root_format = "[$before_root_path](bold cyan)[$repo_root](bold cyan)[$path](bold cyan)[$read_only](red)";
          read_only = " ";
        };

        status = {
          disabled = false;
          format = "[$symbol$common_meaning:$status]($style) ";
          style = "red";
          symbol = " ";
          success_symbol = "";
          not_executable_symbol = "";
          not_found_symbol = "";
          sigint_symbol = "";
          signal_symbol = "";
        };

        nix_shell = {
          format = "via [ $state$name ](blue)";
          impure_msg = "";
          pure_msg = "Pure ";
          unknown_msg = "";
        };

        # Failing right now
        # Will fixed in starship 1.18.0
        # direnv = {
        #   disabled = false;
        #   format = "aboba[$symbol$loaded/$allowed]($style) ";
        #   symbol = "direnv ";
        #   allowed_msg = "allowed";
        #   denied_msg = "denied";
        #   unloaded_msg = "not loaded";
        #   style = "bold green";
        # };

        git_branch = {
          format = "on [$symbol$branch ]($style)";
          style = "bold green";
          symbol = " ";
        };

        lua = {
          disabled = false;
          format = "[$symbol($version )]($style)";
          symbol = "Lua ";
          version_format = "$raw";
          style = "bold blue";
        };

        bun = {
          disabled = false;
          format = "[$symbol($version )]($style)";
          symbol = "Bun ";
          version_format = "$raw";
          style = "bold yellow";
        };

        nodejs = {
          disabled = false;
          format = "[$symbol($version )($engines_version )]($style)";
          symbol = "Node ";
          version_format = "$raw";
          style = "bold green";
          not_capable_style = "bold red";
        };

        golang = {
          disabled = false;
          format = "[$symbol($version )($mod_version )]($style)";
          symbol = "Go ";
          version_format = "$raw";
          style = "bold cyan";
          not_capable_style = "bold red";
        };

        rust = {
          disabled = false;
          format = "[$symbol($version )]($style)";
          symbol = "Rust ";
          version_format = "$raw";
          style = "bold yellow";
        };

        python = {
          disabled = false;
          format = "[$symbol($version)(\($virtualenv\) )]($style)";
          symbol = "Python ";
          version_format = "$raw";
          style = "bold blue";
        };
      };
    };
    home.sessionVariables = {
      STARSHIP_CONFIG = "${config.xdg.configHome}/starship.toml";
      STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
    };
  };
}
