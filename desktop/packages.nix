{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core Utilities
    git
    eza
    fastfetch
    tree
    btop
    p7zip
    ripgrep
    dust
    neovim

    # Polkit
    polkit_gnome

    # Browser
    firefox
  ];

  nixpkgs.config.permittedInsecurePackages = [
  ];
  nixpkgs.config.allowUnsupportedSystem = true;
}
