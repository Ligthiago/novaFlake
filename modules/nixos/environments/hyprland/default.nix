{
  options,
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.modules.environments.hyprland;
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";
in {
  options.modules.environments.hyprland = {
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
    modules.environment.parts = {
      fonts = enabled;
    };

    environment.systemPackages = with pkgs; [
      glib
    ];
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
    ];
    };
    programs.dconf = {
      enable = true;
    };
    environment.extraInit = "
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS;
    ";
  };
}
