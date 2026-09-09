{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stableFull
    winetricks
  ];

  environment.sessionVariables = {
    WINEPREFIX = "$HOME/.local/share/wineprefixes/default";
  };
}
