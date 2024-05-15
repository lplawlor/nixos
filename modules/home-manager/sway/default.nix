{ pkgs, lib, config, ... }:
let
  cfg = config.modules.sway;
in {
  options.modules.sway = { enable = lib.mkEnableOption "sway"; };
  config = lib.mkIf cfg.enable {
    # Add sway-related packages
    # This could go with the other packages in hosts/*/home.nix
    home.packages = with pkgs; [
      autotiling
      shotman
      swaybg
    ];

    # SwayWM settings
    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      config = {
        # Use "Windows" key as modifier
        modifier = "Mod4";
        defaultWorkspace = "workspace number 1";
        terminal = "kitty";
        menu = "wofi --show=drun";

        input = {
          # See 'man 5 sway-input'
          "type:touchpad" = {
            # Enable touchpad tapping
            tap = "enabled";
            # 1 finger = left, 2 finger = right, 3 finger = middle
            tap_button_map = "lrm";
          };
        };

        # No swaybar
        bars = [];

        # Gaps between windows
        gaps = {
          horizontal = 5;
          vertical = 5;
          inner = 5;
        };

        colors = {
          background = "#1e1e2e";

          # See 'man 5 sway'
          # For my setup, I don't want visible indicators (so they use the same color as childBorder)
          # I also want the title background, title border and window border to be the same
          placeholder = {
            border = "#bac2de";
            childBorder = "#bac2de";
            background = "#bac2de";
            indicator = "#bac2de";
            text = "#cdd6f4";
          };
          focused = {
            border = "#cba6f7";
            childBorder = "#cba6f7";
            background = "#cba6f7";
            indicator = "#cba6f7";
            text = "#1e1e2e";
          };
          focusedInactive = {
            border = "#6c7086";
            childBorder = "#6c7086";
            background = "#6c7086";
            indicator = "#6c7086";
            text = "#1e1e2e";
          };
          unfocused = {
            border = "#6c7086";
            childBorder = "#6c7086";
            background = "#6c7086";
            indicator = "#6c7086";
            text = "#cdd6f4";
          };
          urgent = {
            border = "#f38ba8";
            childBorder = "#f38ba8";
            background = "#f38ba8";
            indicator = "#f38ba8";
            text = "#1e1e2e";
          };
        };

        # This will combine with the default keybindings
        # Note that equivalent keybinds like "Shift+E" and "Shift+e" will not overwrite one another,
        # but will cause conflicts when sway tries to reactivate with the newly generated config file.
        keybindings = let
          # Get the modifier key defined above
          modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          # Volume
          "XF86AudioLowerVolume" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          # Swaylock
          "${modifier}+Shift+e" = "exec swaylock --daemonize";

          # Shotman
          "--locked Print" = "exec shotman --capture output";
          "Control+Print" = "exec shotman --capture region";
          "${modifier}+Print" = "exec shotman --capture window";
        };

        # Disable titlebar (it's shown in Waybar)
        window.titlebar = false;
      };

      # Extra config for autotiling and swaybg
      extraConfig = ''
        exec_always autotiling
        output * bg ${../../../wallpapers/moon_2x.png} center #181825
      '';
    };

    # Swaylock settings
    # Make sure to add `security.pam.services.swaylock = {};` to the NixOS config
    programs.swaylock = {
      enable = true;

      # Use the swaylock-effects package for bonus effects
      package = pkgs.swaylock-effects;
      settings = {
        # swaylock-effects settings
        indicator = true;
        clock = true;

        # Base swaylock settings
        image = "${../../../wallpapers/deck_2x.png}";
        scaling = "center";
        font = "JetBrainsMono Nerd Font";
        font-size = 16;
        indicator-radius = 100;
        color="#181825";
        key-hl-color="#a6e3a1";
        caps-lock-key-hl-color="#a6e3a1";
        bs-hl-color="#eba0ac";
        caps-lock-bs-hl-color="#eba0ac";
        inside-color="#181825";
        inside-clear-color="#181825";
        inside-caps-lock-color="#181825";
        inside-ver-color="#181825";
        inside-wrong-color="#181825";
        layout-text-color="#cdd6f4";
        layout-bg-color="#00000000";
        layout-border-color="#00000000";
        line-color="#00000000";
        line-clear-color="#00000000";
        line-caps-lock-color="#00000000";
        line-ver-color="#00000000";
        line-wrong-color="#00000000";
        ring-color="#cba6f7";
        ring-clear-color="#cba6f7";
        ring-caps-lock-color="#cba6f7";
        ring-ver-color="#89b4fa";
        ring-wrong-color="#eba0ac";
        separator-color="#00000000";
        text-color="#cba6f7";
        text-clear-color="#cba6f7";
        text-caps-lock-color="#cba6f7";
        text-ver-color="#89b4fa";
        text-wrong-color="#eba0ac";
      };
    };

  };
}
