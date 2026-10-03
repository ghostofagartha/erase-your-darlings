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
    fastfetch
    tree
    starship
    btop
    p7zip-rar
    ripgrep
    dust
    neovim
    ventoy-full

    # Desktop
    gpu-screen-recorder

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
    "ventoy-1.1.17"
  ];
  nixpkgs.config.allowUnsupportedSystem = true;
}
