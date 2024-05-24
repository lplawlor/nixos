{ lib, config, ... }:
let
  cfg = config.modules.wofi;
in {
  options.modules.wofi = { enable = lib.mkEnableOption "wofi"; };
  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      settings = {
        style = "${./style.css}";
        prompt = "";
      };
    };
  };
}
