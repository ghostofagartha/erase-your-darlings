{ lib, ... }:

{
  # Gaming & Performance
  programs.gamemode.enable = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
  powerManagement.cpuFreqGovernor = "performance";

  # 1. DISABLE THERMALD (It forces the 15W restriction via Lenovo firmware)
  services.thermald.enable = false;

  # 2. ENABLE THROTTLED (Overrides the hardware limits to pull 25W+ continuously)
  services.throttled = {
    enable = true;
    extraConfig = "
      GENERAL = {
        Sysfs_Power_Path = "/sys/class/power_supply/AC*/online";
      };

      # Behavior when plugged into the wall charger
      POWER_AC = {
        Update_Rate_Sustained_Power_Limit = 25; # Pull 25W forever instead of 15W!
        Update_Rate_Burst_Power_Limit = 35;     # Let the CPU peak up to 35W temporarily
        Trip_Temp_C = 90;                       # Max allowable temperature threshold
      };

      # Behavior on battery (Keep lower to prevent battery degradation)
      POWER_BATTERY = {
        Update_Rate_Sustained_Power_Limit = 15;
        Update_Rate_Burst_Power_Limit = 22;
        Trip_Temp_C = 80;
      };

      # Undervolting coefficients (Reduces voltage to curb thermal output at 25W)
      UNDERVOLT = {
        CORE = -80;
        CACHE = -80; # Note: Core and Cache offsets must align perfectly
        GPU = -40;
      };
    ";
  };
}
