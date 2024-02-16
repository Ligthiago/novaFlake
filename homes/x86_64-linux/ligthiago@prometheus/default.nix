{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.nova;
with userData.ligthiago; {
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  services.dunst = {
    enable = true;
  };

  modules = {
    environments = {
      hyprland = enabled;
    };
    applications = {
      firefox = enabled;
      obsidian = enabled;
      obs-studio = enabled;
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
      amdgputop = enabled;
      baobab = enabled;
      helix = enabled;
      kitty = enabled;
      disks = enabled;
      file-roller = enabled;
      musikcube = enabled;

      defaultApplications = {
        terminal = "kitty";
        fileManager = "nautilus";
        textEditor = "helix";
        browser = "firefox";
        videoPlayer = "celluloid";
        imageViewer = "loupe";
      };
    };
    webApplications = {
      yarr = enabled;
    };
    shells = {
      bash = enabled;
      nushell = enabled;
      fish = enabled;
      parts = {
        starship = enabled;
        atuin = enabled;
        zellij = enabled;
        carapace = enabled;
      };
      default = "nu";
    };
    tools = {
      git = {
        enable = true;
        userName = name;
        userEmail = email;
      };
      zoxide = enabled;
      eza = enabled;
      yt-dlp = enabled;
      bat = enabled;
      pastel = enabled;
      fastfetch = enabled;
      jq = enabled;
      tldr = enabled;
      hyperfine = enabled;
      imagemagick = enabled;
      curl = enabled;
      gallery-dl = enabled;
      tdl = enabled;
      pet = enabled;
      just = enabled;
      ffmpeg = enabled;
      pget = enabled;
    };
    services = {
      gammastep = enabled;
      pueue = enabled;
    };
  };

  home.stateVersion = "23.11";
}
