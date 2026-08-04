{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.lazyvim.homeManagerModules.default
    inputs.caelestia-shell.homeManagerModules.default
  ];

  home.username = "aori";
  home.homeDirectory = "/home/aori";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;     # Note: singular "autosuggestion" in Home Manager
    syntaxHighlighting.enable = true;

    initContent = ''
      # Custom sequences / colors hook
      cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

      # Custom Caelestia greeting banner for Zsh
      function zsh_greeting() {
        echo -ne '\x1b[38;5;16m'  # Set colour to primary
        echo '     ______           __          __  _       '
        echo '    / ____/___ ____  / /__  _____/ /_(_)___ _ '
        echo '   / /   / __ `/ _ \/ / _ \/ ___/ __/ / __ `/ '
        echo '  / /___/ /_/ /  __/ /  __(__  ) /_/ / /_/ /  '
        echo '  \____/\__,_/\___/_/\___/____/\__/_/\__,_/   '
        echo -ne '\x1b[0m'             # Reset color to normal
        command -v fastfetch &> /dev/null && fastfetch --key-padding-left 5
      }

      # Execute the banner once when opening a new interactive terminal shell
      zsh_greeting
      
      # Starship custom prompt hook
      command -v starship &> /dev/null && eval "$(starship init zsh)"

      # Direnv + Zoxide hooks
      command -v direnv &> /dev/null && eval "$(direnv hook zsh)"
      command -v zoxide &> /dev/null && eval "$(zoxide init zsh --cmd cd)"

      # Foot terminal prompt jump marker 
      function mark_prompt_start() {
        print -n "\e]133;A\e\\"
      }
      precmd_functions+=(mark_prompt_start)

      # Caelestia user config fallback hook
      XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
      if [ -f "$XDG_CONFIG_HOME/caelestia/user-config.zsh" ]; then
        source "$XDG_CONFIG_HOME/caelestia/user-config.zsh"
      elif [ -f "$HOME/.config/caelestia/user-config.zsh" ]; then
        source "$HOME/.config/caelestia/user-config.zsh"
      fi
    '';

    # Mapping your exact Fish 'abbr' variables to Zsh interactive aliases
    shellAliases = {
      # Better ls
      ls = "eza --icons --group-directories-first -1";
      l = "ls";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";

      # Git shorthand bindings
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

  # LazyVim
  programs.lazyvim = {
  enable = true;
  extras = {
    lang.nix.enable = true;
  };
  plugins = {
    colorscheme = ''
      return {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
          flavour = "mocha", -- "transparent" is not a valid flavour
          transparent_background = true,
          term_colors = true,
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
          },
        },
        config = function(_, opts)
          require("catppuccin").setup(opts)
          -- Force transparency for UI elements that the plugin might miss
          vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "catppuccin",
            callback = function()
              vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
              vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
              vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
              vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
              vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
              vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
            end,
          })
          vim.cmd.colorscheme("catppuccin")
        end,
      }
    '';
    };
  };

  # Starship
  programs.starship = {
    enable = true;
    enableFishIntegration = true; 
  };

  # Point Cursor
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    size = 24;
  };

  # Fonts
  fonts.fontconfig.enable = true;

  # Mpv
  programs.mpv = {
    enable = true;
    config = {
      save-position-on-quit = "yes";
    };
  };

  # Polkit
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      WantedBy = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  home.packages = with pkgs; [
    # Inputs
    inputs.caelestia-shell.packages.${stdenv.hostPlatform.system}.with-cli
    inputs.caelestia-cli.packages.${stdenv.hostPlatform.system}.with-shell

    # Core Utilities
    wineWow64Packages.wayland

    # Hyprland
    foot
    zoxide
    gum
    yazi
    glib
    starship
    fuzzel
    wl-clipboard
    swappy
    cliphist
    libcava
    lm_sensors
    upower
    qt6.qtdeclarative
    material-symbols
    libqalculate

    # Documents
    libreoffice
    obsidian

    # Internet
    whatsapp-electron
    ferdium
    equibop
    thunderbird
  ];
}

