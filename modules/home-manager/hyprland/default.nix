{ lib, config, ... }:
let
  cfg = config.modules.hyprland;
in {
  options.modules.hyprland = { enable = lib.mkEnableOption "hyprland"; };
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = ",preferred,auto,1";

        # Dwindle layout
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        # Run hyprpaper on start
        exec-once = "hyprpaper";

        general = {
          layout = "dwindle";
          gaps_in = 5;
          gaps_out = 5;
          border_size = 2;
          "col.active_border" = "rgba(cba6f7ee) rgba(f5c2e7ee) 45deg";
          "col.inactive_border" = "rgba(585b70aa)";
        };

        decoration = {
          rounding = 10;
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = "overshoot, 0.05, 0.9, 0.1, 1.1";
          animation = [
            "windows, 1, 7, overshoot"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        gestures.workspace_swipe = true;

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          background_color = "0x181825";
        };

        # Normal binds
        bind = [
          # Focus window
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          # Move window
          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, right, movewindow, r"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, down, movewindow, d"

          # Focus workspace (on same monitor)
          "SUPER CTRL, left, workspace, r-1"
          "SUPER CTRL, right, workspace, r+1"

          # Move focused window to workspace (on same monitor)
          "SUPER CTRL SHIFT, left, movetoworkspace, r-1"
          "SUPER CTRL SHIFT, right, movetoworkspace, r+1"

          # Focus monitor
          "SUPER ALT, left, focusmonitor, -1"
          "SUPER ALT, right, focusmonitor, +1"

          # Move focused window to monitor
          "SUPER ALT SHIFT, left, movewindow, mon:-1"
          "SUPER ALT SHIFT, right, movewindow, mon:+1"

          "SUPER, C, killactive"
          "SUPER, P, pseudo"
          "SUPER, J, togglesplit"
          "SUPER, V, togglefloating"
          "SUPER, F11, fakefullscreen"

          # Launch
          "SUPER, Q, exec, kitty"
          "SUPER, F, exec, firefox"
          "SUPER, R, exec, wofi --normal-window --show drun"

          # Screenshot
          "SUPER, PRINT, exec, hyprshot -m window"
          ", PRINT, exec, hyprshot -m output"
          "SHIFT, PRINT, exec, hyprshot -m region"
        ];

        # Mouse binds
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        # Repeating binds
        binde = [
          # Volume controls
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    };
  };
}
