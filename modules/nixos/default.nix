{ ... }: {
  system = {
    stateVersion = "23.11";
  };

  imports = [
    ./bluetooth
    ./bootloader
    ./docker
    ./gnupg
    ./networking
    ./pipewire
    ./plymouth
    ./sddm
    ./steam
    ./system
  ];
}
