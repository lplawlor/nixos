{ lib, config, ... }:
let
  cfg = config.modules.kitty;
in {
  options.modules.kitty = { enable = lib.mkEnableOption "kitty"; };
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      font = {
        name = "JetBrains Mono";
      };
      shellIntegration.enableZshIntegration = true;
      settings = {
        # Disable prompt when closing Kitty
        confirm_os_window_close = 0;
      };
    };
  };
}
