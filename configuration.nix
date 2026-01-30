{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./modules/persistence.nix
    ./modules/performance.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    # ./modules/virtualization.nix
    ./modules/users.nix
    ./modules/nix-ld.nix
  ];

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Karachi";
  i18n.defaultLocale = "en_GB.UTF-8";

  environment.systemPackages = with pkgs; [
    vim
    neovim
    firefox
    git
    unzip
    p7zip
    wget
    tree
    fastfetch
  ];

  # --- System Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
  ];

  # --- NIX MAINTENANCE ---
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- NIX SETTINGS ---
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
