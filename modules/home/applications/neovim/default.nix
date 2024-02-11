{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.applications.neovim;
in {
  options.modules.applications.neovim = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable neovim module.
      Neovim is a terminal editor, focused on extensibility and usability.
      Source: https://github.com/neovim/neovim
      Documentation: https://neovim.io/doc/
    '');
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

    xdg.desktopEntries."nvim" = {
      name = "Neovim";
      genericName = "Text Editor";
      categories = ["Utility" "TextEditor"];
      type = "Application";
      terminal = true;
      icon = "nvim";
      comment = "Terminal text editor";
      exec = "nvim %F";
      settings = {
        Keywords = "Text;Code;Editor;";
      };
    };
  };
}
