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
        home-manager
        fastfetch
      ];
    };

    # Configured modules
    modules = {
      bat.enable = true;
      direnv.enable = true;
      fonts.enable = true;
      gh.enable = true;
      git.enable = true;
      nixvim.enable = true;
      xdg.enable = true;
      zsh.enable = true;
    };
  };
}
