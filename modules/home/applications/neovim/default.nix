{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.applications.neovim;
in {
  options.configuration.applications.neovim = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable neovim module.
      Neovim is a terminal editor, focused on extensibility and usability.
      Source: https://github.com/neovim/neovim
      Documentation: https://neovim.io/doc/
    '');
    desktopName = mkOpt types.str "nvim" "Name of desktop file";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      clipboard.providers.wl-copy.enable = true;
      plugins = {
        nix.enable = true;
        nvim-tree = {
          enable = true;
        };
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    xdg.desktopEntries."${cfg.desktopName}" = {
      name = "Neovim";
      genericName = "Text Editor";
      categories = ["Utility" "TextEditor"];
      type = "Application";
      terminal = true;
      icon = "nvim";
      comment = "Terminal text editor";
      exec = "nvim %F";
      settings = {
        Keywords = "TUI;Text;Code;Editor;";
      };
    };
  };
}
