{ ... }:

{
  networking = {
    hostName = "Phantom";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 ];
    };
  };
}
