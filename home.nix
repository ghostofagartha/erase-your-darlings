{ config, pkgs, inputs, caelestia-shell, ... }:

{
  # Imports
  imports = [
    caelestia-shell.homeManagerModules.default
  ];

  # User
  home.username = "aori";
  home.homeDirectory = "/home/aori";
  home.stateVersion = "25.05";

  # Point Cursor
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
  
  # Hyprland Settings
  wayland.windowManager.hyprland = {
    enable = true;

    # Configuration Settings
    settings = {

      # General
      general = {
        gaps_in = 5;
	      gaps_out = 15;
	      border_size = 2;
	      layout = "master";
      };

      # 'Master' Layout
      master = {
	      new_status = "master";
        mfact = 0.5;
        orientation = "left";
      };

      # Monitor Settings
      monitor = ",preferred,auto,1";
      "$mod" = "SUPER";

      # Keybindings
      bind = [
        # Basic Navigation Keybinds
	      "$mod, Return, exec, kitty"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
	      "$mod, W, exec, firefox"
        "$mod, E, exec, nautilus"
        "$mod, P, togglefloating,"
	      "$mod, F, fullscreen, 0"
	      "$mod, D, fullscreen, 1"
	      "$mod SHIFT, S, movetoworkspace, special"
	      "$mod SHIFT, G, movetoworkspace, e+0"
        "$mod, S, togglespecialworkspace"

        # Caelestia Shell Keybinds
        "$mod, Escape, exec, caelestia-shell ipc call drawers toggle \"session\""
        "$mod, N, exec, caelestia-shell ipc call drawers toggle \"dashboard\""
        "$mod, U, exec, caelestia-shell ipc call drawers toggle \"utilities\""
	      "$mod, I, exec, caelestia-shell ipc call controlCenter open"
	      "$mod, SPACE, exec, caelestia-shell ipc call drawers toggle launcher"
	      "$mod, L, exec, caelestia-shell ipc call lock lock"
  	    ", Print, exec, caelestia-shell ipc call picker open"

        # Changing Workspace Keybinds
	      "$mod, 1, workspace, 1"
  	    "$mod, 2, workspace, 2"
  	    "$mod, 3, workspace, 3"
  	    "$mod, 4, workspace, 4"
  	    "$mod, 5, workspace, 5"
  	    "$mod, 6, workspace, 6"
  	    "$mod, 7, workspace, 7"
  	    "$mod, 8, workspace, 8"
  	    "$mod, 9, workspace, 9"
  	    "$mod, 0, workspace, 10"
  	    "$mod, Prior, workspace, e-1"
  	    "$mod, Next, workspace, e+1"

        # Moving Programs Across Workspaces Keybinds
  	    "$mod SHIFT, 1, movetoworkspace, 1"
  	    "$mod SHIFT, 2, movetoworkspace, 2"
  	    "$mod SHIFT, 3, movetoworkspace, 3"
  	    "$mod SHIFT, 4, movetoworkspace, 4"
  	    "$mod SHIFT, 5, movetoworkspace, 5"
  	    "$mod SHIFT, 6, movetoworkspace, 6"
  	    "$mod SHIFT, 7, movetoworkspace, 7"
  	    "$mod SHIFT, 8, movetoworkspace, 8"
  	    "$mod SHIFT, 9, movetoworkspace, 9"
  	    "$mod SHIFT, 0, movetoworkspace, 10"

        # Focus Window Keybinds
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Changing Location of Windows
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Top Row Keybinds
	      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"
	      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, caelestia-shell ipc call brightness set $(echo \"$(caelestia-shell ipc call brightness get) + 0.1\" | bc)"
        ", XF86MonBrightnessDown, exec, caelestia-shell ipc call brightness set $(echo \"$(caelestia-shell ipc call brightness get) - 0.1\" | bc)"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      bindm = [
	      "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Inputs Setting
      input = {
	      kb_layout = "gb";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
	      };
      };

      # Decorations and Aesthetics
      decoration = {
	    rounding = 10;
	    active_opacity = 0.95;
	    inactive_opacity = 0.7;
	    fullscreen_opacity = 1.0;
        blur = {
          enabled = false;
          size = 3;
          passes = 1;
        };
      };
    };
  };

  # Kitty Terminal Settings
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha"; 
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    # Configuration Settings
    settings = {
      background_opacity = "0.8";
      dynamic_background_opacity = true;
      
      window_padding_width = 10;
      confirm_os_window_close = 0;
      
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      cursor_shape = "beam";
      cursor_blink_interval = 0.5;

      repaint_delay = 8;
      input_delay = 2;
      sync_to_monitor = true;
      disable_ligatures = "never";
    };

    # Keybindings
    keybindings = {
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+c" = "copy_to_clipboard";
    };
  };

  # User Packages
  home.packages = with pkgs; 
  [
    home-manager 
    bc
    brightnessctl
    wireplumber
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    swayidle
  ];

  # Enabled Programs
  programs.caelestia.enable = true;
  programs.home-manager.enable = true;
}
