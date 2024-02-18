{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.nova;
with userData.ligthiago; {
  configuration = {
    settings = {
      user = {
        username = "ligthiago";
        name = "Donets Andrey";
        email = "donets.andre@gmail.com";
      };
      defaults = {
        terminal = "kitty";
        fileManager = "nautilus";
        textEditor = "helix";
        browser = "firefox";
        videoPlayer = "celluloid";
        imageViewer = "loupe";
        shell = "nu";
      };
      stateVersion = "23.11";
    };

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
        direnv = enabled;
      };
    };

    tools = {
      git = enabled;
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
      yq = enabled;
    };

    services = {
      pueue = enabled;
    };
  };
}
