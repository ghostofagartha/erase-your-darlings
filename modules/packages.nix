{ input, pkgs, stablePkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    # Core Utilities
    wget
    git
    fastfetch
    tree
    p7zip
    ripgrep

    # Tools
    wineWow64Packages.stable
    vim
    neovim

    # Browser
    firefox

    # Programming
    jdk25
    gcc
    rustup
    zed-editor

    # Cyber Security
    /*nmap
    openvpn
    theharvester
    sqlmap
    torsocks
    wireshark
    burpsuite
    macchanger
    firejail*/
      
    # Documents
    onlyoffice-desktopeditors
    obsidian

    # Internet
    # discord
    thunderbird
    stablePkgs.wasistlos
  ];
}
