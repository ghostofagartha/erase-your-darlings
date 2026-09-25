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

    # Coding
    gcc
    zed-editor
    jetbrains.clion

    # Internet
    whatsapp-electron
    qbittorrent
    ferdium
    equibop
    teams-for-linux
    thunderbird
  ];
}
