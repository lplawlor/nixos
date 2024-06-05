{ pkgs, lib, config, ... }:
let
  cfg = config.modules.cursors;
in {
  options.modules.cursors = { enable = lib.mkEnableOption "cursors"; };
  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      name = "catppuccin-mocha-mauve-cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 16;
      gtk.enable = true;
    };
  };
}
