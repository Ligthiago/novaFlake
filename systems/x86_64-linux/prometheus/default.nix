# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}:
with lib.nova; {
  imports = [./hardware.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "prometheus";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Saratov";

  users.users.andrey = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel" "storage" "disk" "audio" "video" "networkmanager" "input"];
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    python3
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Temp
  services.dbus.packages = [pkgs.evince];
  systemd.packages = [pkgs.evince];

  services.gnome.gnome-keyring.enable = true;

  modules = {
    hardware = {
      backlight = enabled;
      audio = enabled;
      bluetooth = enabled;
    };
    services = {
      tlp = enabled;
      vnstat = enabled;
      gvfs = enabled;
      upower = enabled;
    };
    environments = {
      hyprland = enabled;
    };
    security = {
      firejail = enabled;
    };
  };

  services.greetd = let
    session = {
      command = "${lib.getExe config.programs.hyprland.package}";
      user = "andrey";
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
