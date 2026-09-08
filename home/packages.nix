{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Desktop
    foot
    nautilus

    # Documents
    libreoffice
    obsidian

    # Coding
    gcc

    # Internet
    whatsapp-electron
    ferdium
    equibop
    thunderbird
  ];
}
