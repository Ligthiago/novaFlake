{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; {
  imports = [
    ./hardware.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "theseus";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Saratov";

  users.users.ligthiago = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel" "storage" "disk" "audio" "video" "networkmanager" "input"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  modules = {
    hardware = {
      audio = enabled;
      bluetooth = enabled;
    };
    services = {
      vnstat = enabled;
      gvfs = enabled;
    };
    environments = {
      hyprland = enabled;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.greetd = let
    session = {
      command = "${lib.getExe config.programs.hyprland.package}";
      user = "ligthiago";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  system.stateVersion = "23.11";
}
