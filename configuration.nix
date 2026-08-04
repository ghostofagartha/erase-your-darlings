{ config, lib, pkgs, inputs, ... }:

{
# Imports
  imports = [ 
    ./hardware-configuration.nix
    ./modules/persistence.nix
    ./modules/performance.nix
    ./modules/boot.nix
    ./modules/users.nix
    ./modules/ld.nix
    ./desktop/desktop.nix
    ./desktop/sddm.nix
    ./desktop/packages.nix
  ];

  # Networking & Identity
  networking = {
    hostName = "Phantom";
    networkmanager.enable = true;
    firewall.enable = true;
  };
  time.timeZone = "Asia/Karachi";
  i18n.defaultLocale = "en_GB.UTF-8";

  # --- System Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
  ];

  # Force enable the core polkit framework
  security.polkit.enable = true;

  # --- NIX MAINTENANCE ---
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- NIX SETTINGS ---
  nix.settings.auto-optimise-store = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
