{ pkgs, lib, config, ... }:
let
  cfg = config.modules.system;
in {
  options.modules.system = { enable = lib.mkEnableOption "system"; };
  config = lib.mkIf cfg.enable {
    # Time zone
    time.timeZone = "America/St_Johns";

    # Locale
    i18n.defaultLocale = "en_CA.UTF-8";

    # Security
    security = {
      rtkit.enable = true;
      polkit.enable = true;
    };

    # User account
    users.users.lplawlor = {
      isNormalUser = true;
      description = "lplawlor";
      extraGroups = [
        "networkmanager" # Allows network configuration
        "wheel"
        "docker" # Allows usage of Docker
        "video" # Allows usage of media keys
      ];
    };

    # Use ZSH by default
    users.defaultUserShell = pkgs.zsh;

    environment.sessionVariables = {
      # Wayland hint for Chromium / Electron apps
      NIXOS_OZONE_WL = "1";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "lplawlor" ];
    };
  };
}
