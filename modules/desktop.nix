{ pkgs, ... }:

{
  # --- GNOME ---
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Remove GNOME Bloat
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-maps
    gnome-weather
    geary
    epiphany 
  ]);

  # Hyprland
  programs.hyprland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
