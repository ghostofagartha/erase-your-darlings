{ pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5;
    consoleLogLevel = 0;
  };

  # Hardware Optimizations
  services.fstrim.enable = true;
  
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = false;
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
  };
}
