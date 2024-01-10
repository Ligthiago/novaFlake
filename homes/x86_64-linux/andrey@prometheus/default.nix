{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.nova; {
  home = {
    username = "andrey";
    homeDirectory = "/home/andrey";
  };

  programs.home-manager.enable = true;

  # Temporally enable git this way
  programs.git = {
    enable = true;
    userName = "Andrey Donets";
    userEmail = "donets.andre@gmail.com";
  };

  nova = {
    environments = {
      hyprland = enabled;
    };
    applications = {
      alacritty = enabled;
    };
  };

  modules = {
    applications = {
      neovim = enabled;
      nautilus = enabled;
      celluloid = enabled;
      btop = enabled;
      loupe = enabled;
      evince = enabled;
      vscode = enabled;
    };
    shells = {
      bash = enabled;
      nushell = enabled;
      parts = {
        starship = enabled;
        atuin = enabled;
      };
    };
    tools = {
      zoxide = enabled;
      eza = enabled;
    };
  };

  home.stateVersion = "23.11";
}
