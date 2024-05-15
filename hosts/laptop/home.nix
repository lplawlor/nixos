{ pkgs, inputs, ... } : {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../../modules/home-manager
  ];

  config = {
    # Unconfigured user packages
    home = {
      username = "lplawlor";
      homeDirectory = "/home/lplawlor";
      packages = with pkgs; [
        devenv
        discord
        home-manager
        fastfetch
        pavucontrol
        vlc
      ];
    };

    # Configured modules
    modules = {
      cursors.enable = true;
      direnv.enable = true;
      firefox.enable = true;
      fonts.enable = true;
      gh.enable = true;
      git.enable = true;
      gtk.enable = true;
      kitty.enable = true;
      mako.enable = true;
      nixvim.enable = true;
      sway.enable = true;
      vscode.enable = true;
      waybar.enable = true;
      wofi.enable = true;
      xdg.enable = true;
      zsh.enable = true;
    };
  };
}
