{ pkgs, ... }: {

  services.ollama = {
    enable = true;
    package = pkgs.ollama; 
  };

  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/var/lib/ollama" # Stores your downloaded 2GB+ model files directly on NVMe
    ];
  };

}
