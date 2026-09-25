{ inputs, pkgs, ... }:

{
  # --- Desktop ---
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.niri.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.upower.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # --- Audio ---
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
