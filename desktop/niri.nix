{ inputs, pkgs, ... }:

{
  # --- Desktop ---
  services.xserver.enable = true;
  programs.niri.enable = true;
  services.upower.enable = true;

  # --- Audio ---
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
