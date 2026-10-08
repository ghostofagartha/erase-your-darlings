{ lib, ... }:

{
  # Gaming & Performance
  programs.gamemode.enable = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
  powerManagement.cpuFreqGovernor = "performance";

  # Disable thermald so it stops enforcing the 15W firmware ceiling
  services.thermald.enable = false;

  # Correct declarative structure using extraConfig
  services.throttled = {
    enable = true;
    extraConfig = ''
      [GENERAL]
      Sysfs_Power_Path: /sys/class/power_supply/AC*/online

      [POWER.AC]
      Update_Rate_Sustained_Power_Limit: 25
      Update_Rate_Burst_Power_Limit: 35
      Trip_Temp_C: 90

      [POWER.BATTERY]
      Update_Rate_Sustained_Power_Limit: 15
      Update_Rate_Burst_Power_Limit: 22
      Trip_Temp_C: 80

      [UNDERVOLT]
      CORE: -80
      CACHE: -80
      GPU: -40
    '';
  };
}
