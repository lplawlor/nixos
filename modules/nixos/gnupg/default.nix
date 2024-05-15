{ lib, config, ... }:
let
  cfg = config.modules.gnupg;
in {
  options.modules.gnupg = { enable = lib.mkEnableOption "gnupg"; };
  config = lib.mkIf cfg.enable {
    programs.gnupg.agent.enable = true;
  };
}
