{ lib, config, ... }:
let
  cfg = config.modules.networking;
in {
  options.modules.networking = { enable = lib.mkEnableOption "networking"; };
  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;
      
      # Use alternative DNS as fallbacks
      insertNameservers = [
        "1.1.1.1" # Cloudflare
        "9.9.9.9" # Quad9
        "8.8.8.8" # Google
      ];
    };
  };
}
