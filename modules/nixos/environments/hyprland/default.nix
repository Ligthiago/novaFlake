{
  options,
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.nova.environments.hyprland;
in {
  options.nova.environments.hyprland = {
    enable = mkEnableOption (lib.mdDoc "Enable Hyprland compositor and basic features");
  };
  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };
}
