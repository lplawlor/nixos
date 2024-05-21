{ lib, config, ... }:
let
  cfg = config.modules.zsh;
in {
  options.modules.zsh = { enable = lib.mkEnableOption "zsh"; };
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      history = {
        # Ignore duplicate history entries
        ignoreDups = true;
        ignoreAllDups = true;

        # Don't save commands beginning with " " to the history
        ignoreSpace = true;

        # Share history between sessions
        share = true;
      };

      # Only search through history entries matching the current partial command
      historySubstringSearch.enable = true;

      # Add Fish-style autosuggestions
      autosuggestion.enable = true;

      # Enable syntax highlighting
      syntaxHighlighting.enable = true;

      # OMZ config
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

      # Aliases
      shellAliases = {
        l = "lsd";
        ls = "lsd";
        ll = "lsd -l";
        la = "lsd -A";
        lla = "lsd -lA";
        c = "clear";
      };

      localVariables = {
        # Use bat (without just line numbers) as the default pager
        PAGER = "bat -n";

        # Use nvim as the default editor
        EDITOR = "nvim";
      };
    };
  };
}
