{ pkgs, ... }:

{
  services.fprintd.enable = true;

  security.pam.services = {
    sddm.fprintAuth = true;
    sudo.fprintAuth = true;
  };

  environment.systemPackages = [
    pkgs.fprintd
  ];
}
