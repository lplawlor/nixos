{ ... }: {
  home = {
    stateVersion = "23.11";
  };

  imports = [
    ./bat
    ./cursors
    ./direnv
    ./firefox
    ./fonts
    ./gh
    ./git
    ./gtk
    ./hyprland
    ./kitty
    ./mako
    ./nixvim
    ./sway
    ./vscode
    ./waybar
    ./wofi
    ./xdg
    ./zsh
  ];
}
