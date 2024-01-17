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
    modules.environments.parts = {
      gtk = enabled;
      swayidle = disabled;
      xdg = enabled;
      rofi = enabled;
      eww = disabled;
      ags = enabled;
    };

    home.packages = with pkgs; [
      grimblast
      hyprpicker
      swww
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      plugins = [
        inputs.hycov.packages.${pkgs.system}.hycov
      ];
      settings = {
        env = [
          "GDK_BACKEND,wayland"
          "SDL_VIDEODRIVER,wayland,x11"
          "CLUTTER_BACKEND,wayland"
          "NIXOS_OZONE_WL,1"
        ];
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
        dwindle = {
          preserve_split = true;
        };
        bind =
          [
            "SUPER, Q, killactive"
            "SUPER, M, exit"

            "SUPER, V, togglefloating"
            "SUPER SHIFT, Z, alterzorder, bottom"

            "SUPER, F, fullscreen, 1"
            "SUPER ALT, F, fullscreen"
            "SUPER SHIFT, F, fakefullscreen"

            "SUPER, W, movefocus, u"
            "SUPER, A, movefocus, l"
            "SUPER, S, movefocus, d"
            "SUPER, D, movefocus, r"
            "SUPER, up, movefocus, u"
            "SUPER, left, movefocus, l"
            "SUPER, down, movefocus, d"
            "SUPER, right, movefocus, r"

            "SUPER SHIFT, W, swapwindow, u"
            "SUPER SHIFT, A, swapwindow, l"
            "SUPER SHIFT, S, swapwindow, d"
            "SUPER SHIFT, D, swapwindow, r"
            "SUPER SHIFT, up, swapwindow, u"
            "SUPER SHIFT, left, swapwindow, l"
            "SUPER SHIFT, down, swapwindow, d"
            "SUPER SHIFT, right, swapwindow, r"

            "SUPER, X, togglesplit"
            "SUPER, P, pin"

            "SUPER, E, exec, rofi -show drun"

            "SUPER, T, exec, alacritty"
            "SUPER, Y, exec, nautilus"
            "SUPER, U, exec, firefox"
            "SUPER, I, exec, codium"

            "SUPER, Tab, hycov:toggleoverview"
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
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
        windowrule = [
          "float,^(io.github.celluloid_player.Celluloid)$"
          "center,^(io.github.celluloid_player.Celluloid)$"
          "size 80% 80%,^(io.github.celluloid_player.Celluloid)$"
          "animation popin,^(io.github.celluloid_player.Celluloid)$"

          "float,^(org.gnome.Loupe)$"
          "center,^(org.gnome.Loupe)$"
          "size 80% 80%,^(org.gnome.Loupe)$"
          "animation popin,^(org.gnome.Loupe)$"
        ];
      };
      extraConfig = ''
        bind = SUPER, R, submap, resize
        submap = resize
        binde = SUPER, W, resizeactive, 0 -20
        binde = SUPER, A, resizeactive, -20 0
        binde = SUPER, S, resizeactive, 0 20
        binde = SUPER, D, resizeactive, 20 0
        binde = SUPER, up, resizeactive, 0 -20
        binde = SUPER, left, resizeactive, -20 0
        binde = SUPER, down, resizeactive, 0 20
        binde = SUPER, right, resizeactive, 20 0

        bind = SUPER SHIFT, W, movefocus, u
        bind = SUPER SHIFT, A, movefocus, l
        bind = SUPER SHIFT, S, movefocus, d
        bind = SUPER SHIFT, D, movefocus, r
        bind = SUPER SHIFT, up, movefocus, u
        bind = SUPER SHIFT, left, movefocus, l
        bind = SUPER SHIFT, down, movefocus, d
        bind = SUPER SHIFT, right, movefocus, r

        bind = SUPER, X, togglesplit
        bind = SUPER, E, splitratio, exact 1
        bind = SUPER, R, submap, reset
        bind = , escape, submap, reset
        submap = reset

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
