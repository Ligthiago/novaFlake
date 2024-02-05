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
    imagemagick
    grim
    slurp
    jq
    wl-clipboard
    libnotify
    ffmpeg
    just
  ];

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
      alacritty = disabled;

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
      fish = disabled;
      parts = {
        starship = enabled;
        atuin = enabled;
        zellij = enabled;
        carapace = enabled;
      };
    };
    tools = {
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
    };
    services = {
      gammastep = enabled;
      pueue = enabled;
    };
  };

  home.stateVersion = "23.11";
}
