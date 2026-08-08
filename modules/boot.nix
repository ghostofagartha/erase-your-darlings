{ pkgs, config, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 10;
    consoleLogLevel = 0;
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ 
      acpi_call 
    ];
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
