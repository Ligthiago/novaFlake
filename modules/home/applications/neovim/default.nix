{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.applications.neovim;
in {
  options.modules.applications.neovim = {
    enable = mkEnableOption (lib.mdDoc "Enable neovim module");
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
