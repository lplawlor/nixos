{ lib, config, ... }:
let
  cfg = config.modules.bootloader;
in {
  options.modules.bootloader = { enable = lib.mkEnableOption "bootloader"; };
  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
