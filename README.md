# Flake-based NixOS and Home-Manager Configuration

Use `sudo nixos-rebuild switch --flake .#<hostname>` to rebuild the NixOS system with the specified hostname.
The `#<hostname>` part of that command can be skipped if the current hostname is already the same as one defined in the flake.
Updating the NixOS configuration will also update the home-manager configuration.

Likewise, use `home-manager switch --flake .` to switch the home-manager configuration only.
This could be useful on non-NixOS systems, though I haven't tested that yet.

Use `nix flake update` to update the package versions in `flake.lock`, then rebuild the system using the above command to update the system.

