{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.shells.parts.starship;
in {
  options.modules.shells.parts.starship = {
    enable = mkEnableOption (lib.mdDoc "Enable starship shell promt module");
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
          $shell$directory$git_branch$nix_shell$lua$status
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
        nix_shell = {
          format = "via [ $state$name](blue) ";
          impure_msg = "";
          pure_msg = "Pure ";
          unknown_msg = "";
        };
        git_branch = {
          format = "on [$symbol$branch]($style) ";
          style = "bold green";
          symbol = " ";
        };
        lua = {
          format = "via [$symbol($version )]($style) ";
          symbol = "";
          style = "blue";
        };
        status = {
          disabled = false;
          format = "[$symbol $common_meaning:$status]($style) ";
          style = "red";
          symbol = "";
          success_symbol = "";
          not_executable_symbol = "";
          not_found_symbol = "";
          sigint_symbol = "";
          signal_symbol = "";
        };
      };
    };
  };
}
