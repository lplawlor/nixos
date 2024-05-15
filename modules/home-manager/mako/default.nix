{ lib, config, ... }:
let
  cfg = config.modules.mako;
in {
  options.modules.mako = { enable = lib.mkEnableOption "mako"; };
  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;
      backgroundColor = "#1e1e2e";
      textColor = "#cdd6f4";
      progressColor = "#313244";
      borderColor = "#f38ba8";
      borderRadius = 8;
      borderSize = 2;
    };
  };
}
