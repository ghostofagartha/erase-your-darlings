{ pkgs, ... }:

{
  # --- Power Profiles Daemon: performance/balanced/power-saver ---
  services.power-profiles-daemon.enable = true;

  # --- Battery charge thresholds, independent of TLP ---
  systemd.services.battery-charge-threshold = {
    description = "Set battery charge thresholds";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "set-charge-threshold" ''
        for bat in /sys/class/power_supply/BAT*; do
          if [ -f "$bat/charge_control_start_threshold" ]; then
            echo 75 > "$bat/charge_control_start_threshold" || true
          fi
          if [ -f "$bat/charge_control_end_threshold" ]; then
            echo 80 > "$bat/charge_control_end_threshold" || true
          fi
        done
      '';
    };
  };

  systemd.services.battery-charge-threshold-resume = {
    description = "Reapply battery charge thresholds after resume";
    after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "reapply-charge-threshold" ''
        for bat in /sys/class/power_supply/BAT*; do
          if [ -f "$bat/charge_control_start_threshold" ]; then
            echo 75 > "$bat/charge_control_start_threshold" || true
          fi
          if [ -f "$bat/charge_control_end_threshold" ]; then
            echo 80 > "$bat/charge_control_end_threshold" || true
          fi
        done
      '';
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
