{
  options,
  config,
  inputs,
  pkgs,
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
      plugins = [
        inputs.hycov.packages.${pkgs.system}.hycov
      ];
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
            "workspaces,1,6,simple,slidevert"
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
        bind =
          [
            "SUPER,Q,killactive"
            "SUPER,E,exec,alacritty"
            "SUPER,M,exit"
            "SUPER,V,togglefloating"

            "SUPER,W,movefocus,u"
            "SUPER,A,movefocus,l"
            "SUPER,S,movefocus,d"
            "SUPER,D,movefocus,r"

            #Hycov
            "SUPER,Tab,hycov:toggleoverview"
          ]
          ++ (
            builtins.concatLists (builtins.genList (
                x: let
                  workspace = let
                    count = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (count * 10));
                in [
                  "SUPER,${workspace},workspace, ${toString (x + 1)}"
                  "SUPER SHIFT, ${workspace}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              10)
          );
        binde = [
          ",XF86MonBrightnessUp, exec, light -A 5"
          ",XF86MonBrightnessDown, exec, light -U 5"
        ];
        bindm = [
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
        ];
      };
      extraConfig = ''
        plugin {
          hycov {
            overview_gappo = 20
            overview_gappi = 20
            hotarea_size = 10
            enable_hotarea = 0
            swipe_fingers = 4
            move_focus_distance = 100
            enable_gesture = 1
            disable_workspace_change = 1
            disable_spawn = 1
            auto_exit = 1
            auto_fullscreen = 0
            only_active_workspace = 0
            only_active_monitor = 1
            enable_alt_release_exit = 0
            alt_toggle_auto_next = 0
          }
        }
      '';
    };
  };
}
