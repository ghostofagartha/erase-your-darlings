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

    # Browser
    firefox
  ];

  services.locate.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
  ];
  nixpkgs.config.allowUnsupportedSystem = true;
}
