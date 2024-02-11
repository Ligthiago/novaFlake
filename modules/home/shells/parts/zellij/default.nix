{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.shells.parts.zellij;
in {
  options.modules.shells.parts.zellij = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable zellij module.
      Zellij is a terminal multiplexer aimed at developers, ops-oriented people and anyone who loves the terminal.
      Source: https://github.com/zellij-org/zellij
      Documentation: https://zellij.dev/documentation/
    '');
  };
  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      # Autostart
      # enableBashIntegration = mkIf (config.programs.bash.enable) true;
      # enableZshIntegration = mkIf (config.programs.zsh.enable) true;
      # enableFishIntegration = mkIF (config.programs.fish.enable) true;
      settings = {
        default_shell = "nu";
        theme = "nova";
        themes.nova = {
          fg = "#dddddd";
          bg = "#323232";
          black = "#343a40";
          red = "#f03e3e";
          green = "#12b886";
          yellow = "#fab005";
          blue = "#228be6";
          magenta = "#be4bdb";
          cyan = "#22b8cf";
          white = "#dddddd";
          orange = "#fab005";
        };
      };
    };
  };
}
