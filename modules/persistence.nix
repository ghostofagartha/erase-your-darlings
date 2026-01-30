{ config, pkgs, ... }:

{
  fileSystems = {
     "/etc/nixos" = { 
      	device = "/persist/etc/nixos";
    	    fsType = "none";
	    options = [ "bind" ];
    };

    "/etc/machine-id" = {
	    device = "/persist/etc/machine-id";
	    fsType = "none";
	    options = [ "bind" ];
    };

    "/etc/NetworkManager" = {
    	device = "/persist/etc/NetworkManager";
	    fsType = "none";
	    options = [ "bind" ];
    };

    "/var/lib/bluetooth" = { 
      device = "/persist/var/lib/bluetooth";
      fsType = "none";
      options = [ "bind" ];
    };

    "/var/lib/nixos" = { 
      device = "/persist/var/lib/nixos"; 
      fsType = "none"; 
      options = [ "bind" ]; 
      neededForBoot = true; 
    };

    "/var/lib/libvirt" = { 
    	device = "/persist/var/lib/libvirt"; 
	    fsType = "none"; 
	    options = [ "bind" ];
    };

    "/var/lib/swtpm" = { 
	    device = "/persist/var/lib/swtpm"; 
	    fsType = "none"; 
	    options = [ "bind" ]; 
    };
  };
}
