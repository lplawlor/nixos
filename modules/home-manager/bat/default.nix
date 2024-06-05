{ pkgs, lib, config, ... }:
let
  cfg = config.modules.bat;
in {
  options.modules.bat = { enable = lib.mkEnableOption "bat"; };
  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      themes = {
        "Catppuccin Mocha" = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
            hash = "sha256-Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
      config = {
        theme ="Catppuccin Mocha";
      };
    };
  };
}
