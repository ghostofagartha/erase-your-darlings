{ pkgs, inputs, ... }:

{
  programs.gpu-screen-recorder = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Core Utilities
    git
    eza
    zoxide
    yazi
    ntfs3g
    fastfetch
    tree
    starship
    btop
    p7zip-rar
    ripgrep
    dust
    neovim
    efibootmgr

    # Desktop
    gpu-screen-recorder
    evtest

    # Display
    xwayland
    xwayland-satellite

    # Browser
    firefox
  ];

  services = {
    flatpak.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
  ];
  nixpkgs.config.allowUnsupportedSystem = true;
}
