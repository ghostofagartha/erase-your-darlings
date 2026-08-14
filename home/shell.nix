{ inputs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      function fish_greeting
        set_color 15
        printf '     ______           __          __  _       \n'
        printf '    / ____/___ ____  / /__  _____/ /_(_)___ _ \n'
        printf '   / /   / __ `/ _ \/ / _ \/ ___/ __/ / __ `/ \n'
        printf '  / /___/ /_/ /  __/ /  __(__  ) /_/ / /_/ /  \n'
        printf '  \____/\__,_/\___/_/\___/____/\__/_/\__,_/   \n'
        set_color normal

        command -v fastfetch &> /dev/null; and fastfetch --key-padding-left 5
      end

      command -v direnv &> /dev/null; and direnv hook fish | source
      command -v zoxide &> /dev/null; and zoxide init fish --cmd cd | source

      function mark_prompt_start
        printf '\e]133;A\e\\'
      end

      functions --copy fish_prompt original_fish_prompt
      function fish_prompt
        mark_prompt_start
        original_fish_prompt
      end
    '';

    shellAliases = {
      ls = "eza --icons --group-directories-first -1";
      l = "ls";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";

      lg = "lazygit";
      gd = "git diff";
      ga = "git add .";
      gc = "git commit -am";
      gl = "git log";
      gs = "git status";
      gst = "git stash";
      gsp = "git stash pop";
      gp = "git push";
      gpl = "git pull";
      gsw = "git switch";
      gsm = "git switch main";
      gb = "git branch";
      gbd = "git branch -d";
      gco = "git checkout";
      gsh = "git show";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
