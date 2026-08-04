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
      "/var/lib/AccountsService"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/db/sudo"
      "/var/cache"
      "/home/aori"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
