{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.nova;
with userData.ligthiago; {
  home =  {
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
      obs-studio = enabled;
      nautilus = enabled;
      celluloid = enabled;
      btop = enabled;
      loupe = enabled;
      evince = enabled;
      vscode = enabled;
      secrets = enabled;
      yazi = enabled;
      baobab = enabled;
      helix = enabled;
      kitty = enabled;
      disks = enabled;
      file-roller = enabled;

      defaultApplications = {
        terminal = "kitty";
        fileManager = "nautilus";
        textEditor = "helix";
        browser = "firefox";
        videoPlayer = "celluloid";
        imageViewer = "loupe";
      };
    };
    shells = {
      bash = enabled;
      nushell = enabled;
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
      pueue = enabled;
    };
  };

  home.stateVersion = "23.11";
}
