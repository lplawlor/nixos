{ pkgs, lib, config, ... }:
let
  cfg = config.modules.waybar;
in {
  options.modules.waybar = { enable = lib.mkEnableOption "waybar"; };
  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          spacing = 0;
          height = 34;
          modules-left = [
            "sway/workspaces"
          ];
          modules-center = [
            "sway/window"
          ];
          modules-right = [
            "network"
            "bluetooth"
            "pulseaudio"
            "backlight"
            "battery"
            "clock"
          ];
          "sway/workspaces" = {
            format = "{name}";
          };
          tray = {
            spacing = 10;
          };
          clock = {
            tooltip-format = "<tt>{calendar}</tt>";
            format-alt = "  {:%a, %d %b %Y}";
            format = "  {:%I:%M %p}";
          };
          bluetooth = {
            format-disabled  = "󰂲";
            format-off  = "󰂲";
            format-on  = "󰂯";
            format-connected  = "󰂱";
            format-connected-battery  = "{device_battery_percentage}% 󰂱";
            tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          };
          network = {
            format-wifi  = "{icon}";
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format-ethernet = "󰀂";
            format-disconnected  = "󰖪";
            tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-disconnected = "Disconnected";
            on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          };
          pulseaudio = {
            format = "{volume}% {icon}";
            format-bluetooth = "{volume}% 󰂰";
            tooltip-format = "{desc}";
            format-muted = "󰝟";
            format-icons = {
            headphone = "";
              default = [
                "󰕿"
                "󰖀"
                "󰕾"
              ];
            };
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            scroll-step = 1;
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
          };
          battery = {
            format = "{capacity}% {icon}";
            format-icons = {
              charging = [
                "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂅"
              ];
              default = [
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
            states = {
              warning = 20;
              critical = 10;
            };
          };
        };
      };
      style = ./style.css;
    };
  };
}
