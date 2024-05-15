{ lib, config, ... }:
let
  cfg = config.modules.gh;
in {
  options.modules.gh = { enable = lib.mkEnableOption "gh"; };
  config = lib.mkIf cfg.enable {
    programs.gh = {
      enable = true;
    };
  };
}
