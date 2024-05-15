{
  description = "NixOS and standalone Home-Manager Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/nixos-wsl";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    home-manager,
    nixos-wsl,
    nixpkgs,
    nixvim,
    vscode-server,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";

    # Function for creating systems
    mkSystem = hostname:
      nixpkgs.lib.nixosSystem {
        modules = [
          # Include home-manager itself as a module
          home-manager.nixosModules.home-manager

          # Nixvim module
          nixvim.nixosModules.nixvim

          # NixOS WSL module
          nixos-wsl.nixosModules.wsl

          # VSCode server module
          vscode-server.nixosModules.default

          # Use a unique hostname per system
          { networking.hostName = hostname; }

          # Host-specific NixOS config
          ./hosts/${hostname}/configuration.nix

          # Host-specific home-manager config
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              users.lplawlor = ./hosts/${hostname}/home.nix;
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };

    # Function for standalone home-manager configuration
    mkHome = hostname:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          # Host-specific home-manager config
          ./hosts/${hostname}/home.nix

          { nixpkgs.config.allowUnfree = true; }
        ];
      };
  in {
    nixosConfigurations = {
      # hostname = mkSystem <hostname>
      laptop = mkSystem "laptop";
      wsl = mkSystem "wsl";
    };

    homeConfigurations = {
      # username@hostname = mkHome <hostname>
      "lplawlor@laptop" = mkHome "laptop";
      "lplawlor@wsl" = mkHome "wsl";
    };
  };
}
