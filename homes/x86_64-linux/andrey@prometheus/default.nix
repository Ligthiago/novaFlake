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

  home.packages = with pkgs; [
    swappy
    grimblast
  ];

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
      firefox = enabled;
      neovim = enabled;
      nautilus = enabled;
      celluloid = enabled;
      btop = enabled;
      s-tui = enabled;
      lazygit = enabled;
      loupe = enabled;
      evince = enabled;
      vscode = enabled;
      secrets = enabled;
      yazi = enabled;
    };
    shells = {
      bash = enabled;
      nushell = enabled;
      parts = {
        starship = enabled;
        atuin = enabled;
        zellij = enabled;
      };
    };
    tools = {
      zoxide = enabled;
      eza = enabled;
      yt-dlp = enabled;
      bat = enabled;
    };
    services = {
      gammastep = enabled;
    };
  };

  home.stateVersion = "23.11";
}
