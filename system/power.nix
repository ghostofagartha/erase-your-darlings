{ config, ... }:

{
  # --- TLP (AC/battery power profiles) ---
  services.tlp = {
    enable = true;
    pd.enable = true;

    settings = {
      # ───── Performance profile (AC) ─────
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_AC = 1;

      # ───── Balanced profile (BAT / GUI Balanced) ─────
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
      CPU_BOOST_ON_BAT = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 1;

      # Cap Balanced at ~85% of available CPU performance.
      # This is mainly to reduce heat/power, while still allowing
      # the CPU to respond quickly to short workloads.
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 85;

      # ───── Battery charging ─────
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # ───── PCIe ─────
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersave";

      # ───── Audio ─────
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;

      # ───── USB ─────
      USB_AUTOSUSPEND = 1;

      # ───── Wi-Fi ─────
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
    };
  };

  # --- Swap / zram ---
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  swapDevices = [ {
    device = "/persist/swapfile";
    priority = 1;
  } ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
  };
}
