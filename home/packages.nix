{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Desktop
    foot
    kdePackages.dolphin

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
