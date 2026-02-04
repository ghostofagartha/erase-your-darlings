{ input, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    # Core Utilities
    wget
    git
    fastfetch
    tree
    p7zip
    unzip
    bat
    fd
    fzf
    ripgrep
    cava

    # Tools
    wineWowPackages.stable
    vim
    neovim
    stylua
    gcc
    gnumake

    # VMs
    qemu
    virt-manager
    virt-viewer
    spice spice-gtk
    spice-protocol
    virtio-win
    win-spice

    # Browser
    tor-browser
    brave
    firefox

    # Programming
    jdk25_headless
    maven
    python3
    rustup
    gcc
    jetbrains.idea
    jetbrains.pycharm
    jetbrains.rust-rover

    # Neovim (Lazyvim)
    neovim
    gcc
    lua-language-server
    nodejs
    npm-check

    # Hyprland
    kitty
    alacritty

    # Cyber Security
    nmap
    openvpn
    theharvester
    sqlmap
    torsocks
    wireshark
    burpsuite
    macchanger
    firejail
      
    # Media
    pear-desktop

    # Documents
    onlyoffice-desktopeditors
    obsidian

    # Internet
    discord
    wasistlos
    thunderbird
  ];

  programs.gpu-screen-recorder.enable = true;
}
