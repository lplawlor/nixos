{ lib, config, ... }:
let
  cfg = config.modules.pipewire;
in {
  options.modules.pipewire = { enable = lib.mkEnableOption "pipewire"; };
  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
