{ pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0;

    consoleLogLevel = 0;
    initrd.verbose = false;
    
    plymouth = {
      enable = true;
      theme = "breeze";
    };

    kernelParams = [
      "quiet" "splash" "boot.shell_on_fail" "loglevel=3"
      "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3"
    ];
  };

  # Hardware Optimizations
  services.fstrim.enable = true;
  zramSwap.enable = true;
  services.thermald.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
  
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = false;
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
  };
}
