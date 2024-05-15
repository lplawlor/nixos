{ lib, config, ... }:
let
  cfg = config.modules.git;
in {
  options.modules.git = { enable = lib.mkEnableOption "git"; };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      aliases = {
        st = "status";
        br = "branch";
        sw = "switch";
        pl = "pull";
        ps = "push";
      };
      signing = {
        signByDefault = true;
        key = "617B37A6D0D7F456CF5C0767A8074B6F5FFF3114";
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}

