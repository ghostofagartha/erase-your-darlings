{ config, pkgs, inputs, ... }:

{
  home.username = "aori";
  home.homeDirectory = "/home/aori";
  home.stateVersion = "25.05";
  
  programs.git.enable = true;

  home.packages = with pkgs; [
    home-manager
  ];

  # home-manager
  programs.home-manager.enable = true;
}
