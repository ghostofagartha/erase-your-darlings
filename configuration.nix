{ config, lib, pkgs, inputs, ... }:

{
# Imports
  imports = [ 
    ./modules/hardware-configuration.nix
    ./modules/persistence.nix
    ./modules/performance.nix
    ./modules/packages.nix
    ./modules/boot.nix
    ./modules/swap.nix
    ./modules/desktop.nix
    ./modules/virtualization.nix
    ./modules/users.nix
    ./modules/nix-ld.nix
  ];

  # Networking & Identity
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Karachi";
  i18n.defaultLocale = "en_GB.UTF-8";

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
