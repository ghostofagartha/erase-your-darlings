{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.lazyvim.homeManagerModules.default
    inputs.noctalia.homeModules.default
    ./home/mpv.nix
    ./home/nvim.nix
    ./home/wine.nix
    ./home/cursor.nix
    ./home/shell.nix
    ./home/noctalia.nix
    ./home/packages.nix
  ];

  # Home Settings
  home.username = "aori";
  home.homeDirectory = "/home/aori";
  home.stateVersion = "26.05";
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXOS_OZONE_WL = "1";
  };
  programs.home-manager.enable = true;

  # Fonts
  fonts.fontconfig.enable = true;
}
