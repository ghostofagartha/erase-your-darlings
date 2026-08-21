{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
    shellAliases = {
      cd = "z";
      cdi = "zi";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
