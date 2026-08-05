{ inputs, pkgs, ... }:

{
  # --- Desktop ---
  services.xserver.enable = true;
  programs.niri.enable = true;
  services.power-profiles-daemon.enable = true;

  # --- Hardware Drivers ---
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Intel
      intel-compute-runtime-legacy1
    ];
  };

    # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}

