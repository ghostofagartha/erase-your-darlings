{ pkgs, ... }:

let
  hp107-driver = pkgs.callPackage ./hp107-driver.nix {};
in
{
  services.printing = {
    enable = true;

    drivers = [
      hp107-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    system-config-printer
  ];
}
