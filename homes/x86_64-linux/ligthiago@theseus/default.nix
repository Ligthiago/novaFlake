{
  lib,
  config,
  ...
}:
with lib;
with lib.nova; {
  configuration = {
    settings = {
      user = {
        username = "ligthiago";
        name = "Andrey Donets";
        email = "donets.andre@gmail.com";
      };
      defaults = {
        shell = "nu";
        terminal = "kitty";
        fileManager = "nautilus";
        textEditor = "helix";
        browser = "firefox";
        videoPlayer = "celluloid";
        imageViewer = "loupe";
        pdfViewer = "evince";
        archiveManager = "file-roller";
      };
      stateVersion = "23.11";
    };

    environments = {
      hyprland = enabled;
    };

    applications = {
      kitty = enabled;
      nautilus = enabled;
      firefox = enabled;
      vscode = enabled;
      obs-studio = enabled;
      inkscape = enabled;
      celluloid = enabled;
      loupe = enabled;
      evince = enabled;
      secrets = enabled;
      btop = enabled;
      yazi = enabled;
      baobab = enabled;
      helix = enabled;
      disks = enabled;
      file-roller = enabled;
      newsflash = enabled;
      calculator = enabled;
      easyeffects = enabled;
      warpinator = enabled;
      dconf-editor = enabled;
    };

    shells = {
      bash = enabled;
      nushell = enabled;
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
      rclone = enabled;
    };

    services = {
      pueue = enabled;
    };
  };
}
