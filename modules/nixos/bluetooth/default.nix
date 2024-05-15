{ lib, config, ... }:
let
  cfg = config.modules.bluetooth;
in {
  options.modules.bluetooth = { enable = lib.mkEnableOption "bluetooth"; };
  config = lib.mkIf cfg.enable {
    # Bluetooth settings
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    # GUI App for bluetooth management
    services.blueman.enable = true;
  };
}
