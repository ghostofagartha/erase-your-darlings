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
      "/etc/libvirt"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/lib/libvirt"
      "/var/db/sudo"
      "/var/cache"
      "/home/aori"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
