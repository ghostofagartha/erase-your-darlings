{ config, pkgs, ... }:

{
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
