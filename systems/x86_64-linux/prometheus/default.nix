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
    extraGroups = ["wheel" "storage" "disk" "audio" "video" "networkmanager"];
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    neofetch
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Temp
  services.dbus.packages = [pkgs.evince];
  systemd.packages = [pkgs.evince];

  modules = {
    hardware = {
      backlight = enabled;
      audio = enabled;
    };
    services = {
      tlp = enabled;
      vnstat = enabled;
      gvfs = enabled;
    };
    environments = {
      hyprland = enabled;
    };
    security = {
      firejail = enabled;
    };
  };

  system.stateVersion = "23.11";
}
