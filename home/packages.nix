{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Desktop
    foot
    nautilus
    localsend

    # Documents
    onlyoffice-desktopeditors
    obsidian
    cherrytree

    # Coding
    gcc
    zed-editor

    # Internet
    whatsapp-electron
    qbittorrent
    ferdium
    google-chrome
    equibop
    teams-for-linux
    thunderbird
  ];
}
