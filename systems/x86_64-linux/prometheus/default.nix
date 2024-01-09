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

  modules = {
    hardware = {
      light = enabled;
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

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
