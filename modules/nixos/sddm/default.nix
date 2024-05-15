{ pkgs, lib, config, ... }:
let
  cfg = config.modules.sddm;
in {
  options.modules.sddm = { enable = lib.mkEnableOption "sddm"; };
  config = lib.mkIf cfg.enable {
    services.displayManager = {
      # SDDM doesn't show the Sway session if it is not included in sessionPackages
      sessionPackages = [ pkgs.sway ];

      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        extraPackages = [ pkgs.qt6.qt5compat ];
        wayland.enable = true;
        theme = "where_is_my_sddm_theme";
      };
    };

    # Packages installed in system profile.
    environment.systemPackages = [
      # SDDM
      (pkgs.where-is-my-sddm-theme.override {
        themeConfig.General = {
          passwordCharacter = "●";
          passwordFontSize = "24";
          passwordInputCursorVisible= false;
          passwordInputRadius = 100;
          passwordInputBackground = "#cba6f7";
          passwordTextColor = "#181825";
          background = "${../../../wallpapers/deck_2x.png}";
          backgroundFillMode = "Pad";
          backgroundFill = "#181825";
          blurRadius = 0;
        };
      })
    ];
  };
}
