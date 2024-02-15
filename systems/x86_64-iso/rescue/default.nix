{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nova; {
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Saratov";

  environment.systemPackages = with pkgs; [
    helix
    git
    curlie
    pget
    fastfetch
  ];

  modules = {
    hardware = {
      bluetooth = enabled;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "23.11";
}
