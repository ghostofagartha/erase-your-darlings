{ pkgs, config, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 10;
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_latest;
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
