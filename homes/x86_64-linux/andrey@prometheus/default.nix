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

  home.packages = with pkgs; [
    alejandra
  ];

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
#    applications = {
 #     neovim = enabled;
 #   };
    shells = {
      bash = enabled;
      parts = {
        starship = enabled;
        atuin = enabled;
      };
    };
    tools = {
      zoxide = enabled;
    };
  };

  home.stateVersion = "23.11";
}
