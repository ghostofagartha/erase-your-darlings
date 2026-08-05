{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.lazyvim.homeManagerModules.default
    inputs.noctalia.homeModules.default
    ./home_modules/mpv.nix
    ./home_modules/nvim.nix
    ./home_modules/pointer.nix
    ./home_modules/shell.nix
    ./home_modules/noctalia.nix
  ];

  # Home Settings
  home.username = "aori";
  home.homeDirectory = "/home/aori";
  home.stateVersion = "26.05";
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs.home-manager.enable = true;

  # Fonts
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Desktop
    foot
    brightnessctl
    alacritty

    # Documents
    libreoffice
    obsidian

    # Internet
    whatsapp-electron
    ferdium
    equibop
    thunderbird
  ];
}

