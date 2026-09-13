{ pkgs, ... }:

{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  documentation.man.cache.enable = false;

  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winePackages.fonts
    winetricks
  ];

  environment.sessionVariables = {
    WINEPREFIX = "$HOME/.local/share/wineprefixes/default";
    WINEARCH = "win64";
  };

  hardware.graphics = {
    enable = true;
  };
}
