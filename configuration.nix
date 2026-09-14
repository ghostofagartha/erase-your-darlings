{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./system/persistence.nix
    ./system/performance.nix
    ./system/hardware.nix
    ./system/power.nix
    ./system/boot.nix
    ./system/users.nix
    ./system/fingerprint.nix
    ./system/nix-ld.nix
    ./system/wine.nix
    ./system/networking.nix
    ./system/nix-settings.nix
    ./system/virtualization.nix

    ./desktop/niri.nix
    ./desktop/sddm.nix
    ./desktop/packages.nix
    ./desktop/variables.nix
  ];

  time.timeZone = "Asia/Karachi";
  i18n.defaultLocale = "en_GB.UTF-8";

  # --- System Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
  ];

  system.stateVersion = "26.05";
}
