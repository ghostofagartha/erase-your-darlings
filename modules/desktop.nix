{ pkgs, lib, ... }:

{
  # --- PLASMA ---
  services.xserver.enable = true;
  services.xserver.xkb.layout = "gb";
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    okular
    kwallet
    kwallet-pam
    kwalletmanager
    kwrited
  ];

  # Hyprland
  #programs.hyprland.enable = true;
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.speechd.enable = lib.mkForce false;
}
