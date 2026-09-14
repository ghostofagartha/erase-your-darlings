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
    zed-editor
    jetbrains.clion

    # Internet
    whatsapp-electron
    ferdium
    equibop
    teams-for-linux
    thunderbird
  ];
}
