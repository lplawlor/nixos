{ pkgs, lib, config, ... }:
let
  cfg = config.modules.vscode;
in {
  options.modules.vscode = { enable = lib.mkEnableOption "vscode"; };
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        bbenoist.nix
        bradlc.vscode-tailwindcss
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        christian-kohler.path-intellisense
        github.vscode-github-actions
        github.vscode-pull-request-github
        yzhang.markdown-all-in-one
      ];
      userSettings = {
        "window.titleBarStyle" = "custom";
        "workbench.activityBar.location" = "top";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "editor.stickyScroll.enabled" = false;
        "extensions.autoUpdate" = false;
        "git.confirmSync" = false;
      };
    };
  };
}
