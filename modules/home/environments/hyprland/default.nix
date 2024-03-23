{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nova; let
  cfg = config.configuration.environments.hyprland;
  defaults = config.configuration.settings.defaults;
  applications = config.configuration.applications;
in {
  options.configuration.environments.hyprland = {
    enable = mkOptEnable (lib.mdDoc ''
      Enable hyprland module.
      Hyprland is a highly customizable dynamic tiling Wayland compositor.
      Source: https://github.com/hyprwm/Hyprland
      Documentation: https://wiki.hyprland.org/
    '');
  };

  config = mkIf cfg.enable {
    # Enable specific for hyprland environment modules
    configuration = {
      environments.parts = {
        gtk = enabled;
        xdg = enabled;
        rofi = enabled;
        eww = disabled;
        ags = enabled;
        dunst = enabled;
      };
      services = {
        polkit-agent = enabled;
      };
    };

    # Enable specific for hyprland environment packages
    home.packages = with pkgs; [
      grim
      slurp
      wl-clipboard
      libnotify
      hyprpicker
      swww
      nova.hyprscreen
      nova.hyprarrange
      socat
      nova.satty
      hyprkeys
      glib
    ];

    # Enable hyprland compositor and apply settings
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = true;
      # Disabled for now, as plugins keep breaking due to the constant changes in Hyprland.
      # Maybe later, when I start using fixed hyprland version
      # plugins = with inputs; [
      #   hycov.packages.${pkgs.system}.hycov
      # ];
      settings = {
        exec = [
          "swww init"
          "swww img ${config.xdg.userDirs.extraConfig.XDG_WALLPAPERS_DIR}/DarkNoise06.png"
        ];
        env = [
          "GDK_BACKEND,wayland"
          "QT_QPA_PLATFORM=wayland"
          "SDL_VIDEODRIVER,wayland"
          "CLUTTER_BACKEND,wayland"
          "NIXOS_OZONE_WL,1"
        ];
        general = {
          gaps_in = 3;
          gaps_out = 6;
          border_size = 1;
          "col.active_border" = "rgb(323232) rgb(525252) 270deg";
          "col.inactive_border" = "rgb(323232) rgb(525252) 270deg";
          layout = "dwindle";
        };
        decoration = {
          rounding = 10;
          blur = {
            enabled = false;
          };
          drop_shadow = true;
          shadow_range = 40;
          "col.shadow" = "rgba(00000050)";
          shadow_render_power = 3;
        };
        animations = {
          enabled = true;
          first_launch_animation = false;
          bezier = [
            "simple,0.13,0.99,0.29,1"
          ];
          animation = [
            "windows,1,5,simple,popin 50%"
            "border,1,5,default"
            "fade,1,5,default"
            "workspaces,1,5,simple,slidevert"
            "layers,1,5,simple,popin 80%"
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
          background_color = "rgba(161616ff)";
        };
        dwindle = {
          preserve_split = true;
        };
        group = {
          "col.border_active" = "rgb(323232) rgb(525252) 270deg";
          "col.border_inactive" = "rgb(323232) rgb(525252) 270deg";
          "col.border_locked_active" = "rgb(323232) rgb(525252) 270deg";
          "col.border_locked_inactive" = "rgb(323232) rgb(525252) 270deg";
          groupbar = {
            enabled = true;
            font_family = "Cantarell";
            font_size = 12;
            gradients = true;
            height = 24;
            text_color = "rgb(dddddd)";
            "col.active" = "rgb(464646)";
            "col.inactive" = "rgb(323232)";
          };
        };
        bind =
          [
            # Focus switching
            "SUPER, W, movefocus, u"
            "SUPER, A, movefocus, l"
            "SUPER, S, movefocus, d"
            "SUPER, D, movefocus, r"
            "SUPER, up, movefocus, u"
            "SUPER, left, movefocus, l"
            "SUPER, down, movefocus, d"
            "SUPER, right, movefocus, r"

            # Move windows
            "SUPER SHIFT, W, movewindow, u"
            "SUPER SHIFT, A, movewindow, l"
            "SUPER SHIFT, S, movewindow, d"
            "SUPER SHIFT, D, movewindow, r"
            "SUPER SHIFT, up, movewindow, u"
            "SUPER SHIFT, left, movewindow, l"
            "SUPER SHIFT, down, movewindow, d"
            "SUPER SHIFT, right, movewindow, r"
            "SUPER SHIFT, c, centerwindow"

            # Window actions
            "SUPER, Q, killactive"
            "SUPER, V, execr, hyprctl activewindow -j | jq -r .class | grep -vqE 'io.bassi.Amberol|org.gnome.Calculator' && hyprctl dispatch togglefloating"
            "SUPER, Z, alterzorder, bottom"
            "SUPER, F, fullscreen, 1"
            "SUPER SHIFT, F, fullscreen"
            "SUPER ALT, F, fakefullscreen"
            "SUPER, X, togglesplit"
            "SUPER, P, pin"
            "SUPER SHIFT, P, pseudo"

            # Group stuff
            "SUPER, G, togglegroup"
            "SUPER SHIFT, G, lockactivegroup"
            "SUPER, bracketleft, changegroupactive, b"
            "SUPER, bracketright, changegroupactive, f"
            "SUPER CTRL, W, movewindoworgroup, u"
            "SUPER CTRL, A, movewindoworgroup, l"
            "SUPER CTRL, S, movewindoworgroup, d"
            "SUPER CTRL, D, movewindoworgroup, r"
            "SUPER CTRL, up, movewindoworgroup, u"
            "SUPER CTRL, left, movewindoworgroup, l"
            "SUPER CTRL, down, movewindoworgroup, d"
            "SUPER CTRL, right, movewindoworgroup, r"

            # Launch applications
            "SUPER, E, exec, rofi -show drun"
            "SUPER, R, exec, ${defaults.terminal}"
            "SUPER SHIFT, R, exec, [float;size exact 60% 60%;center;] ${defaults.terminal}"
            "SUPER, T, exec, ${defaults.fileManager}"
            "SUPER, Y, exec, ${defaults.textEditor}"
            "SUPER, U, exec, ${defaults.browser}"
            "SUPER, I, exec, ${defaults.audioPlayer}"
            "SUPER, O, exec, ${defaults.resourceMonitor}"

            # Extra workspace actions
            "SUPER,mouse_down,workspace,-1"
            "SUPER,mouse_up,workspace,+1"
            "SUPER SHIFT,mouse_down,movetoworkspace,-1"
            "SUPER SHIFT,mouse_up,movetoworkspace,+1"
            "SUPER,minus,workspace,-1"
            "SUPER,equal,workspace,+1"
            "SUPER,backspace, workspace, previous"

            # Misc
            "SUPER, Print, exec, hyprscreen -m screen"
            "SUPER SHIFT, Print, exec, hyprscreen -f"
            "SUPER,F10,pass,^(com.obsproject.Studio)$"
            "SUPER,F11,pass,^(com.obsproject.Studio)$"
          ]
          # Generate keybinds for workspace switch via keyboard
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
                  "SUPER CTRL, ${workspace}, exec, hyprarrange ${toString (x + 1)}"
                  "SUPER CTRL ALT, ${workspace}, exec, hyprarrange -s ${toString (x + 1)}"
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
          "SUPER SHIFT, mouse:273, resizewindow 1"
        ];
        # Remember: Always try to use initialTitle instead of title, because it's safer and more predictable
        windowrulev2 =
          [
            "noshadow, floating:0"

            # Set initial position and size for file picker windows, except application picker in file manager
            "float,class:^(?:(?!Nautilus).)*$,title:^(?:Open|Save|Add|Extract|Pick)(?:(?!\\.).)*$"
            "center,class:^(?:(?!Nautilus).)*$,title:^(?:Open|Save|Add|Extract|Pick)(?:(?!\\.).)*$"
            "size 70% 70%,class:^(?:(?!Nautilus).)*$,title:^(?:Open|Save|Add|Extract|Pick)(?:(?!\\.).)*$"
          ]
          ++ lib.concatLists (lib.optional applications.kitty.enable [
            "minsize 500 300, class:^(kitty)$"
          ])
          ++ lib.concatLists (lib.optional applications.nautilus.enable [
            "minsize 520 470, class:^(org.gnome.Nautilus)$,initialTitle:^(Loading...)$"
          ])
          ++ lib.concatLists (lib.optional applications.firefox.enable [
            "float,class:^(firefox)$,title:^(Library)$"
            "center,class:^(firefox)$,title:^(Library)$"
            "size 80% 80%,class:^(firefox)$,title:^(Library)$"
            "minsize 900 500,class:^(firefox)$,title:^(Library)$"
            "minsize 480 700, class:^(firefox)$,initialTitle:^(Mozilla Firefox)$"

            "float, class:^(firefox)$,title:^(Picture-in-Picture)$"
            "pin, class:^(firefox)$,title:^(Picture-in-Picture)$"
            "size 700 394, class:^(firefox)$,title:^(Picture-in-Picture)$"
            "move onscreen 100%-720 100%-414, class:^(firefox)$,title:^(Picture-in-Picture)$"
          ])
          ++ lib.concatLists (lib.optional applications.vscode.enable [
            "minsize 480 700,class:(codium-url-handler)"
          ])
          ++ lib.concatLists (lib.optional applications.obs-studio.enable [
            "minsize 160 225,class:^(com.obsproject.Studio)$,initialTitle:^(Controls)$"
            "maxsize 160 225,class:^(com.obsproject.Studio)$,initialTitle:^(Controls)$"
            "minsize 340 250,class:^(com.obsproject.Studio)$,initialTitle:^(?:Scenes|Sources|Scene Transitions|Audio Mixer)$"
            "maxsize 340 250,class:^(com.obsproject.Studio)$,initialTitle:^(?:Scenes|Sources|Scene Transitions|Audio Mixer)$"
            "minsize 950 640,class:^(com.obsproject.Studio)$,initialTitle:^(OBS).*$"
          ])
          ++ lib.concatLists (lib.optional applications.evince.enable [
            "minsize 620 850,class:(evince),initialTitle:^(Document Viewer|Recent Documents)*$,title:^(?!Document Viewer)"
            "suppressevent maximize, class:^(evince)$"
          ])
          ++ lib.concatLists (lib.optional applications.foliate.enable [
            "minsize 480 700,class:(com.github.johnfactotum.Foliate),initialTitle:^(Foliate$|Add Catalog$)"
            "size 480 700,class:(com.github.johnfactotum.Foliate),title:^(Add Catalog$)"
            "maxsize 480 700,class:(com.github.johnfactotum.Foliate),title:^(Add Catalog$)"
          ])
          ++ lib.concatLists (lib.optional applications.loupe.enable [
            "float,class:^(org.gnome.Loupe)$"
            "center,class:^(org.gnome.Loupe)$"
            "minsize 400 450,class:^(org.gnome.Loupe)$"
          ])
          ++ lib.concatLists (lib.optional applications.celluloid.enable [
            "float,class:^(io.github.celluloid_player.Celluloid)$"
            "center,class:^(io.github.celluloid_player.Celluloid)$"
            "size 80% 80%,class:^(io.github.celluloid_player.Celluloid)$,title:^(?:(?!About|Preferences).)+$"
            "minsize 400 450,class:^(io.github.celluloid_player.Celluloid)$"
          ])
          ++ lib.concatLists (lib.optional applications.resources.enable [
            "float,class:^(net.nokyan.Resources)$"
            "center,class:^(net.nokyan.Resources)$"
            "size 480 700,class:^(net.nokyan.Resources)$"
            "minsize 360 510, class:^(net.nokyan.Resources)$,title:^(About)$"
            "minsize 480 700, class:^(resources)$,title:^(Preferences)$"
            "minsize 480 700, class:^(net.nokyan.Resources)$"
          ])
          ++ lib.concatLists (lib.optional applications.baobab.enable [
            "float,class:^(org.gnome.baobab)$"
            "center,class:^(org.gnome.baobab)$"
            "size 80% 80%,class:^(org.gnome.baobab)$"
            "minsize 770 420,class:^(org.gnome.baobab)$"
          ])
          ++ lib.concatLists (lib.optional applications.calculator.enable [
            "float,class:^(org.gnome.Calculator)$"
            "center,class:^(org.gnome.Calculator)$"
            "size 340 620,class:^(org.gnome.Calculator)$"
            "minsize 340 620,class:^(org.gnome.Calculator)$"
            "maxsize 680 620,class:^(org.gnome.Calculator)$"
          ])
          ++ lib.concatLists (lib.optional applications.amberol.enable [
            "float,class:^(io.bassi.Amberol)$"
            "center,class:^(io.bassi.Amberol)$"
            "size 360 680,class:^(io.bassi.Amberol)$"
            "minsize 360 680,class:^(io.bassi.Amberol)$"
            "maxsize 680 680,class:^(io.bassi.Amberol)$"
          ])
          ++ lib.concatLists (lib.optional applications.parabolic.enable [
            "float,class:^(org.nickvision.tubeconverter)$"
            "center,class:^(org.nickvision.tubeconverter)$"
            "size 600 800,class:^(org.nickvision.tubeconverter)$,initialTitle:^(Preferences)$"
            "size 450 600,class:^(org.nickvision.tubeconverter)$,initialTitle:^(org.nickvision.tubeconverter)$"
            "size 500 700,class:^(org.nickvision.tubeconverter)$,initialTitle:^(Parabolic)$"
            "minsize 400 450,class:^(org.nickvision.tubeconverter)$,initialTitle:^(Parabolic)$"
          ])
          ++ lib.concatLists (lib.optional applications.cavalier.enable [
            "float,class:^(org.nickvision.cavalier)$"
            "center,class:^(org.nickvision.cavalier)$"
            "size 600 800,class:^(org.nickvision.cavalier)$,title:^(Preferences)$"
            "minsize 600 800,class:^(org.nickvision.cavalier)$,title:^(Preferences)$"
            "maxsize 600 800,class:^(org.nickvision.cavalier)$,title:^(Preferences)$"
            "size 900 500,class:^(org.nickvision.cavalier)$,initialTitle:^(Cavalier)$"
            "minsize 600 400,class:^(org.nickvision.cavalier)$,initialTitle:^(Cavalier)$"
          ])
          ++ lib.concatLists (lib.optional applications.secrets.enable [
            "minsize 400 450,class:^(org.gnome.World.Secrets)$,initialTitle:^(Secrets)$"
            "maxsize 620 900,class:^(org.gnome.World.Secrets)$,initialTitle:^(Secrets)$"
          ])
          ++ lib.concatLists (lib.optional applications.cozy.enable [
            "float,class:^(com.github.geigi.cozy)$,title:^(Cozy)$"
            "center,class:^(com.github.geigi.cozy)$,title:^(Cozy)$"
            "minsize 360 540,class:^(com.github.geigi.cozy)$,initialTitle:^(Cozy)$"
            "maxsize 1200 540,class:^(com.github.geigi.cozy)$,initialTitle:^(Cozy)$"
          ])
          ++ lib.concatLists (lib.optional applications.d-spy.enable [
            "float,class:^(org.gnome.dspy)$,title:^(D-Spy)$"
            "center,class:^(org.gnome.dspy)$,title:^(D-Spy)$"
            "minsize 1000 700,class:^(org.gnome.dspy)$,initialTitle:^(D-Spy)$"
          ]);
        plugin = {
          hycov = {
            overview_gappo = 20;
            overview_gappi = 20;
            hotarea_size = 10;
            enable_hotarea = 0;
            swipe_fingers = 4;
            move_focus_distance = 100;
            enable_gesture = 1;
            disable_workspace_change = 1;
            disable_spawn = 1;
            auto_exit = 1;
            auto_fullscreen = 0;
            only_active_workspace = 0;
            only_active_monitor = 1;
            enable_alt_release_exit = 0;
            alt_toggle_auto_next = 0;
          };
        };
      };
      extraConfig = ''
        bind = SUPER, C, submap, resize
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
        bind = SUPER, C, submap, reset
        bind = , escape, submap, reset
        submap = reset
      '';
    };
  };
}
