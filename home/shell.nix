{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };
}
