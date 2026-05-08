{ pkgs, ... }: 

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    stdenv.cc.cc
    stdenv.cc.cc.lib
    fuse3
    icu
    nss
    openssl
    curl
    expat
    # Add common dependencies for LSPs and Treesitter
    glibc
  ];
}
