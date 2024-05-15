{ pkgs, lib, config, ... }:
let
  cfg = config.modules.plymouth;
in {
  options.modules.plymouth = { enable = lib.mkEnableOption "plymouth"; };
  config = lib.mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      themePackages = [
        (pkgs.catppuccin-plymouth.override { variant = "mocha"; })
      ];
      theme = "catppuccin-mocha";
    };
  };
}
