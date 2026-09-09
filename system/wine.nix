{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
  ];

  hardware.graphics.enable32Bit = true;

  # This moves the default Wine folder out of your home root into .local/share
  environment.sessionVariables = {
    WINEPREFIX = "$HOME/.local/share/wineprefixes/default";
  };
}
