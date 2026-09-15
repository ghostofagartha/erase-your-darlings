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

    # Display
    xwayland

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
