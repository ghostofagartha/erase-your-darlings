{ config, pkgs, ... }:

{
  # --- Power Profiles Daemon: CPU governor/EPP/boost, 3-mode switching ---
  services.power-profiles-daemon.enable = true;

  # --- TLP: everything EXCEPT CPU scaling (no conflict with PPD) ---
  services.tlp = {
    enable = true;
    settings = {
      # ───── Battery charging ─────
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # ───── PCIe ASPM ─────
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # ───── Audio ─────
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;

      # ───── USB autosuspend ─────
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_BTUSB = 1;   # avoid Bluetooth dropouts

      # ───── Wi-Fi power saving ─────
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # ───── Runtime power management (PCI devices) ─────
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      # ───── Disk I/O scheduler ─────
      DISK_IOSCHED = "mq-deadline";

      # ───── SATA link power management ─────
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "min_power";

      # NOTE: deliberately NOT setting any CPU_* keys here
      # (CPU_SCALING_GOVERNOR_*, CPU_ENERGY_PERF_POLICY_*, CPU_BOOST_*,
      #  CPU_HWP_DYN_BOOST_*, CPU_MIN_PERF_*, CPU_MAX_PERF_*)
      # so TLP never touches CPU scaling — that's fully owned by PPD.
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
