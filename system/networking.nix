{ ... }:

{
  networking = {
    hostName = "Phantom";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 53317 1521 ];
      allowedUDPPorts = [ 53317 ];
    };
  };
}
