{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.nova.environments.hyprland;
in {
  options.nova.environments.hyprland = {
    enable = mkEnableOption (lib.mdDoc "Enable Hyprland configs and basic modules");
  };
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        general = {
          gaps_in = 3;
          gaps_out = 6;
          border_size = 1;
          "col.active_border" = "rgba(464646ff)";
          "col.inactive_border" = "rgba(464646ff)";
          layout = "dwindle";
        };
        decoration = {
          rounding = 10;
          blur = {
            enabled = false;
          };
          drop_shadow = false;
        };
        animations = {
          enabled = true;
          bezier = [
            "simple,0.13,0.99,0.29,1"
          ];
          animation = [
            "windows,1,6,simple,slide"
            "border,1,5,default"
            "fade,1,3,default"
            "workspaces,1,6,simple,slidewert"
          ];
        };
        input = {
          kb_model = "";
          kb_layout = "us,ru";
          kb_variant = "";
          kb_options = "grp:alt_shift_toggle";
          kb_rules = "";
          follow_mouse = true;
          touchpad = {
            natural_scroll = false;
          };
        };
        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
          workspace_swipe_distance = 300;
          workspace_swipe_create_new = true;
          workspace_swipe_forever = true;
        };
        xwayland = {
          force_zero_scaling = true;
          use_nearest_neighbor = true;
        };
        misc = {
          disable_hyprland_logo = true;
          background_color = "rgba(1e1e1eff)";
        };
        bind = [
          "SUPER,Q,killactive"
          "SUPER,E,exec,alacritty"
          "SUPER,M,exit"
          "SUPER,V,togglefloating"
        ];
      };
    };
  };
}
