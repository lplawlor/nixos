{ pkgs, ... } : {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix # This is not tracked by git
  ];

  config = {
    # Needed to allow Swaylock to use authentication
    # Could be done by programs.sway.enable, but that overrides the home manager sway config
    security.pam.services.swaylock = {};

    # Unconfigured system packages
    environment.systemPackages = with pkgs; [
      bat
      gh
      lsd
      ripgrep
      tealdeer
      unzip
      wget
      wl-clipboard
      zoxide
    ];
    
    # Unconfigured system programs
    programs = {
      dconf.enable = true;
      git.enable = true;
      nixvim.enable = true;
      waybar.enable = true;
      zsh.enable = true;
    };

    # Unconfigured system services
    services = {
      illum.enable = true;
      upower.enable = true;
    };

    # Configured modules (from modules/nixos/default.nix)
    modules = {
      bluetooth.enable = true;
      bootloader.enable = true;
      docker.enable = true;
      gnupg.enable = true;
      networking.enable = true;
      pipewire.enable = true;
      plymouth.enable = true;
      sddm.enable = true;
      system.enable = true;
    };
  };
}
