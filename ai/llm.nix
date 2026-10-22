{ config, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    loadModels = [ "qwen2.5-coder:7b" ];
    environmentVariables = {
      OLLAMA_NUM_PARALLEL = "1";
    };
  };
  environment.systemPackages = with pkgs; [
    ollama
  ];
}
