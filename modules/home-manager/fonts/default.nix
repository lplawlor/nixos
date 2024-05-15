{ pkgs, lib, config, ... }:
let
  cfg = config.modules.fonts;
in {
  options.modules.fonts = { enable = lib.mkEnableOption "fonts"; };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
