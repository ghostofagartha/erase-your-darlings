{ pkgs, ... }:

{
  imports = [
  ];

  # --- Desktop/Hyprland ---
  services.xserver.enable = true;
  programs.hyprland = { 
    enable = true;
    withUWSM = true;
  };
  programs.gpu-screen-recorder.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  security.polkit.enable = true;

  # --- For Disks Mounting
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # --- Hardware Drivers ---
  hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    intel-media-driver # For Intel
    ];
  };

    # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
