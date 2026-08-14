{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Desktop
    foot

    # Games
    hmcl

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
