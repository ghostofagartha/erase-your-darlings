{ pkgs, ...}:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      samsung-unified-linux-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    system-config-printer
  ];
}
