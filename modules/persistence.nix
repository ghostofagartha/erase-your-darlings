{ config, lib, inputs, ... }:

{
  imports = [ 
    inputs.impermanence.nixosModules.impermanence 
  ];

  # Impermanence configuration
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/etc/libvirt/qemu"
      "/var/lib/AccountsService"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/db/sudo"
      "/var/log"
      "/var/lib/libvirt"
      "/var/cache"
      "/home/aori"
      "/root/.config/nvim"
      "/root/.local/share/nvim"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
