{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks
  ];

  environment.sessionVariables = {
    WINEPREFIX = "$HOME/.local/share/wineprefixes/default";
  };
}
