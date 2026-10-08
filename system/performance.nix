{ lib, ... }:

{
  # Gaming & Performance
  programs.gamemode.enable = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;
}
