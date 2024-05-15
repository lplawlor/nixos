{ lib, config, ... }:
let
  cfg = config.modules.xdg;
in {
  options.modules.xdg = { enable = lib.mkEnableOption "xdg"; };
  config = lib.mkIf cfg.enable {
    xdg = {
      enable = true;
    };
  };
}
