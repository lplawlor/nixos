{ pkgs, lib, config, ... }:
let
  cfg = config.modules.gtk;
in {
  options.modules.gtk = { enable = lib.mkEnableOption "gtk"; };
  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Compact-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "compact";
          tweaks = [ "rimless" ];
          variant = "mocha";
        };
      };
    };
  };
}
