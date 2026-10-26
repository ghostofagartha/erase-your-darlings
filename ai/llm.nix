{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    acceleration = null; 
  };

  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/var/lib/ollama"
    ];
  };
}
