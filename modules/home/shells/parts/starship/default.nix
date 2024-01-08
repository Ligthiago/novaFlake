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
      enableNushellIntegration =
        if config.programs.nushell.enable
        then true
        else false;
      enableFishIntegration =
        if config.programs.fish.enable
        then true
        else false;
      enableBashIntegration =
        if config.programs.bash.enable
        then true
        else false;
      enableZshIntegration =
        if config.programs.zsh.enable
        then true
        else false;
      enableIonIntegration =
        if config.programs.ion.enable
        then true
        else false;
      settings = {
        format = ''
          $shell$directory$nix_shell
        '';
        add_newline = false;
        shell = {
          disabled = false;
          format = "[$indicator](bold green) ";
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
          format = "in [$path](bold cyan)[$read_only](red) ";
          repo_root_format = "[$before_root_path](bold cyan)[$repo_root](bold cyan)[$path](bold cyan)[$read_only](red)";
        };
        nix_shell = {
          format = "via [$state( \n($name\))](bold cyan)";
          impure_msg = "Impure shell";
          pure_msg = "Pure shell";
          unknown_msg = "Unknown shell";
        };
      };
    };
  };
}
