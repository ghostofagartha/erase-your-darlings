{ inputs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = { 
      enable = true;
      styles = {
        # Main text
      default = "fg=#e8dfe5";

      # Commands
      command = "fg=#e8dfe5";
      builtin = "fg=#e8dfe5";
      function = "fg=#e8dfe5";
      alias = "fg=#e8dfe5";

      # Arguments / values
      arg0 = "fg=#e8dfe5";
      arg1 = "fg=#e8dfe5";
      arg2 = "fg=#e8dfe5";
      arg3 = "fg=#e8dfe5";

      # Paths
      path = "fg=#e8dfe5";

      # Options
      single-hyphen-option = "fg=#d6b8c8";
      double-hyphen-option = "fg=#d6b8c8";

      # Strings
      single-quoted-argument = "fg=#c9bec7";
      double-quoted-argument = "fg=#c9bec7";

      # Comments
      comment = "fg=#6e6a86";

      # Invalid commands — muted dusty rose instead of red
      unknown-token = "fg=#c98f9d";
      };
    };

    initContent = ''
      function zsh_greeting() {
        echo -ne '\x1b[38;5;15m'
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
