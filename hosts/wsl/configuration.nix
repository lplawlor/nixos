{ lib, pkgs, ... } : {
  imports = [
    ../../modules/nixos
  ];

  config = {
    # Enable WSL
    wsl = {
      enable = true;
      defaultUser = "lplawlor";
    };

    # Needed as it would usually be set in hardware-configuration.nix
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    # Unconfigured system packages
    environment.systemPackages = with pkgs; [
      wget
      wl-clipboard
    ];
    
    # Unconfigured system programs
    programs = {
      git.enable = true;
      nix-ld.enable = true;
      nixvim.enable = true;
      zsh.enable = true;
    };

    # Unconfigured system services
    services = {
      vscode-server.enable = true;
    };

    # Configured modules (from modules/nixos/default.nix)
    modules = {
      gnupg.enable = true;
      networking.enable = true;
      system.enable = true;
    };
  };
}
