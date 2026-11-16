{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    # functions.fish_greeting = ''
    #   echo -ne '\x1b[38;5;216m'  # Set colour to primary
    #   echo '      __  ____                _       ___ ____'
    #   echo '     /  |/  (_)___  ____ _   | |     / (_) __/__  __  __'
    #   echo '    / /|_/ / / __ \/ __ `/   | | /| / / / /_/ _ \/ / / /'
    #   echo '   / /  / / / / / / /_/ /    | |/ |/ / / __/  __/ /_/ /'
    #   echo '  /_/  /_/_/_/ /_/\__,_/     |__/|__/_/_/  \___/\__, /'
    #   echo '                                               /____/'
    #   set_color normal
    # '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };
}
