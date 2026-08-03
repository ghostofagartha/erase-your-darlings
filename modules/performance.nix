{ lib, ... }:

{
  # Gaming & Performance
  programs.gamemode.enable = true;
  boot.kernel.sysctl = { 
    "vm.max_map_count" = 2147483642;
  };
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;
}
