{ lib, config, ... }:
let
  cfg = config.modules.steam;
in {
  options.modules.steam = { enable = lib.mkEnableOption "steam"; };
  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };
  };
}
