{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.environments.parts.gtk;
  #  configure-gtk = pkgs.writeTextFile {
  #    name = "configure-gtk";
  #    destination = "/bin/configure-gtk";
  #    executable = true;
  #    text = let
  #      schema = pkgs.gsettings-desktop-schemas;
  #      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
  #    in ''
  #      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
  #    '';
  #  };
in {
  options.modules.environments.parts.gtk = {
    enable = mkEnableOption (lib.mdDoc "Enable gtk customisation module");
  };
  config = mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 24;
    };
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme.override {color = "brown";};
      };
    };
    home.packages = with pkgs; [
      #configure-gtk
    ];
  };
}
