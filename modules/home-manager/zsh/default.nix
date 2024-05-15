{ lib, config, ... }:
let
  cfg = config.modules.zsh;
in {
  options.modules.zsh = { enable = lib.mkEnableOption "zsh"; };
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "nicoulaj";
        plugins = [
          "direnv"
          "git"
          "gpg-agent"
          "zoxide"
        ];
      };
      shellAliases = {
        l = "lsd";
        ls = "lsd";
        ll = "lsd -l";
        la = "lsd -A";
        lla = "lsd -lA";
        c = "clear";
      };
      localVariables = {
        PAGER = "bat -n";
        EDITOR = "nvim";
      };
    };
  };
}
