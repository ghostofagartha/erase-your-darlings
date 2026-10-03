{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Desktop
    foot
    nautilus

    # Documents
    onlyoffice-desktopeditors
    obsidian
    cherrytree

    # Games
    steam
    steam-run

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
