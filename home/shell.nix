{ inputs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      function zsh_greeting() {
        echo -ne '\x1b[38;2;137;220;235m'
        echo '     ______           __          __  _       '
        echo '    / ____/___ ____  / /__  _____/ /_(_)___ _ '
        echo '   / /   / __ `/ _ \/ / _ \/ ___/ __/ / __ `/ '
        echo '  / /___/ /_/ /  __/ /  __(__  ) /_/ / /_/ /  '
        echo '  \____/\__,_/\___/_/\___/____/\__/_/\__,_/   '
        echo -ne '\x1b[0m'
        command -v fastfetch &> /dev/null && fastfetch --key-padding-left 5
      }

      zsh_greeting

      command -v starship &> /dev/null && eval "$(starship init zsh)"
      command -v direnv &> /dev/null && eval "$(direnv hook zsh)"
      command -v zoxide &> /dev/null && eval "$(zoxide init zsh --cmd cd)"

      function mark_prompt_start() {
        print -n "\e]133;A\e\\"
      }
      precmd_functions+=(mark_prompt_start)
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
