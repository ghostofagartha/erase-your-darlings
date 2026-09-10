{ config, pkgs, ... }:

{
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };
  programs.virt-manager.enable = true;
}
