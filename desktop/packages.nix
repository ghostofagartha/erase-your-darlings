{ pkgs, inputs, ... }:

{
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
    "ventoy-full"
  ];
  nixpkgs.config.allowUnsupportedSystem = true;
}
