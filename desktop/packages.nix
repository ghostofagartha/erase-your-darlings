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
    p7zip
    ripgrep
    dust
    neovim

    # Niri
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Browser
    firefox
  ];

  nixpkgs.config.permittedInsecurePackages = [
  ];
  nixpkgs.config.allowUnsupportedSystem = true;
}
