{ pkgs, ... }:

{
  users.mutableUsers = false;
  users.users.root.hashedPassword = "$6$HySaGf2KB17VfMyh$XWGXqB.EQRszz/aE.okOvafbdVViKGSxeevy7ARhlDE/8ayGKaeU0Knvxhkpdvn.AwLatxwHatY1SOU2fSAAd0";

  users.users.aori = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "render" "video" "libvirtd" ];
    hashedPassword = "$6$jMy.J1W64oPNZ6WG$ivJyoDSxPVtlKiUZ7/CDSgxdR0yjSryW1UXWeoCnIhxF.col/RCBAnbA18xd5Oa1ExP33jWhuH5kJ.b0wFHW81";
  };

  # Global Wine Settings
  environment.variables = {
    WINEARCH = "win64";
    WINEPREFIX = "/home/aori/.wine";
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "ghostofagartha";
      user.email = "darkside4464@gmail.com";
      credential.helper = "store --file /persist/etc/nixos/.git-credentials";
      safe.directory = "/persist/etc/nixos";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
