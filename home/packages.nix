{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Desktop
    foot

    # Documents
    libreoffice
    obsidian

    # Internet
    whatsapp-electron
    ferdium
    equibop
    thunderbird
  ];

  services = {
    flatpak.enable = true;
  };
}
