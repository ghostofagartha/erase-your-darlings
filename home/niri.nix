{ config, lib, pkgs, ... }:

let
  sh = cmd: { spawn-sh = cmd; };

  workspaceBinds = lib.listToAttrs (lib.concatMap (i:
    let n = toString i; in [
      { name = "Mod+${n}";      value.action.focus-workspace = i; }
      { name = "Mod+Ctrl+${n}"; value.action.move-column-to-workspace = i; }
    ]) (lib.range 1 9));

  radius = 10.0;
in
{
  programs.niri.settings = {

    # ── Input ────────────────────────────────────────────────────────────
    input = {
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus.enable = true;

      keyboard.xkb.layout = "gb";

      touchpad = {
        tap = true;
        natural-scroll = true;
      };

      mouse = { };
      trackpoint = { };
    };

    # ── Display ──────────────────────────────────────────────────────────
    outputs."eDP-1" = {
      mode = { width = 1920; height = 1080; refresh = 60.0; };
      scale = 1.0;
      transform.rotation = 0;
      position = { x = 1280; y = 0; };
    };

    # ── Layout ───────────────────────────────────────────────────────────
    layout = {
      gaps = 16;
      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      default-column-width = { proportion = 0.5; };

      focus-ring = {
        width = 1;
        active.color = "#c4a7e7";
        inactive.color = "#505050";
      };

      border = {
        enable = false; # `off` in the KDL
        width = 4;
        active.color = "#ffc87f";
        inactive.color = "#505050";
        urgent.color = "#9b0000";
      };

      # No `on` in your KDL, so niri treats the shadow as disabled.
      # Flip `enable` to true if you actually want it.
      shadow = {
        enable = false;
        softness = 30;
        spread = 5;
        offset = { x = 0; y = 5; };
        color = "#0007";
      };

      struts = { };
    };

    # ── Misc ─────────────────────────────────────────────────────────────
    prefer-no-csd = true;

    spawn-at-startup = [
      { command = [ "noctalia" ]; }
      # Recent niri-flake versions manage xwayland-satellite for you;
      # remove this line if you see two instances.
      { command = [ "xwayland-satellite" ]; }
    ];

    hotkey-overlay.skip-at-startup = true;

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    animations = { };

    # ── Window rules ─────────────────────────────────────────────────────
    window-rules = [
      # Global (no match)
      {
        # NOTE: background-effect is very new; if niri-flake doesn't type it
        # yet, see the fallback note at the bottom.
        background-effect = { blur = false; xray = false; };
      }
      {
        matches = [ { app-id = ''^org\.wezfurlong\.wezterm$''; } ];
        default-column-width = { };
      }
      {
        geometry-corner-radius = {
          top-left = radius;
          top-right = radius;
          bottom-left = radius;
          bottom-right = radius;
        };
        clip-to-geometry = true;
      }
      {
        matches = [ { app-id = "dev.noctalia.Noctalia"; } ];
        open-floating = true;
        default-column-width = { fixed = 1080; };
        default-window-height = { fixed = 920; };
      }
      {
        matches = [ { app-id = "firefox$"; title = "^Picture-in-Picture$"; } ];
        open-floating = true;
      }
      # Disabled in your KDL (`/-window-rule`), kept here for reference:
      # {
      #   matches = [
      #     { app-id = ''^org\.keepassxc\.KeePassXC$''; }
      #     { app-id = ''^org\.gnome\.World\.Secrets$''; }
      #   ];
      #   block-out-from = "screen-capture";
      # }
    ];

    # ── Layer rules ──────────────────────────────────────────────────────
    layer-rules = [
      {
        matches = [ { namespace = "^noctalia-backdrop"; } ];
        place-within-backdrop = true;
      }
      {
        matches = [ { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"; } ];
        background-effect.xray = false;
      }
      {
        matches = [ { namespace = "noctalia-window-switcher"; } ];
        background-effect = { blur = false; xray = false; };
      }
    ];

    # ── Debug ────────────────────────────────────────────────────────────
    debug.honor-xdg-activation-with-invalid-serial = [ ];

    # ── Binds ────────────────────────────────────────────────────────────
    binds = {
      # Applications
      "Mod+T" = { hotkey-overlay.title = "Open a Terminal: foot";      action.spawn = "foot"; };
      "Mod+W" = { hotkey-overlay.title = "Open a Browser: firefox";    action.spawn = "firefox"; };
      "Mod+E" = { hotkey-overlay.title = "Open a File Explorer: yazi"; action = sh "foot -e yazi"; };
      "Super+Alt+L" = { hotkey-overlay.title = "Lock the Screen"; action = sh "noctalia msg session lock"; };

      # Noctalia shell
      "Mod+Space".action      = sh "noctalia msg panel-toggle launcher";
      "Mod+S".action          = sh "noctalia msg panel-toggle control-center";
      "Mod+Tab".action        = sh "noctalia msg window-switcher";
      "Mod+Ctrl+Alt+R".action = sh "pkill noctalia && noctalia -d";
      "Mod+Ctrl+S".action     = sh "noctalia msg settings-toggle [context]";
      "Mod+B".action          = sh "noctalia msg bar-toggle";
      "Mod+V".action          = sh "noctalia msg panel-toggle clipboard";
      "Mod+N".action          = sh "noctalia msg panel-toggle control-center notifications";
      "Mod+Shift+N".action    = sh "noctalia msg notification-clear-active";
      "Ctrl+Alt+C".action     = sh "noctalia msg notification-clear-history";

      # Volume
      "XF86AudioRaiseVolume".action = sh "noctalia msg volume-up";
      "XF86AudioLowerVolume".action = sh "noctalia msg volume-down";
      "XF86AudioMute".action        = sh "noctalia msg volume-mute";
      "XF86AudioMicMute" = { allow-when-locked = true; action = sh "noctalia msg mic-mute"; };

      # Media
      "Mod+Ctrl+Space" = { allow-when-locked = true; action = sh "noctalia msg media toggle"; };
      "Mod+Ctrl+P"     = { allow-when-locked = true; action = sh "noctalia msg media previous"; };
      "Mod+Ctrl+N"     = { allow-when-locked = true; action = sh "noctalia msg media next"; };

      # Brightness
      "XF86MonBrightnessUp".action   = sh "noctalia msg brightness-up";
      "XF86MonBrightnessDown".action = sh "noctalia msg brightness-down";

      "Mod+O" = { repeat = false; action.toggle-overview = [ ]; };
      "Mod+Q" = { repeat = false; action.close-window = [ ]; };

      # Focus
      "Mod+Left".action  = { focus-column-left = [ ]; };
      "Mod+Down".action  = { focus-window-down = [ ]; };
      "Mod+Up".action    = { focus-window-up = [ ]; };
      "Mod+Right".action = { focus-column-right = [ ]; };

      "Mod+H".action = { focus-column-left = [ ]; };
      "Mod+J".action = { focus-window-down = [ ]; };
      "Mod+K".action = { focus-window-up = [ ]; };
      "Mod+L".action = { focus-column-right = [ ]; };

      # Move
      "Mod+Ctrl+Left".action  = { move-column-left = [ ]; };
      "Mod+Ctrl+Down".action  = { move-window-down = [ ]; };
      "Mod+Ctrl+Up".action    = { move-window-up = [ ]; };
      "Mod+Ctrl+Right".action = { move-column-right = [ ]; };

      "Mod+Ctrl+H".action = { move-column-left = [ ]; };
      "Mod+Ctrl+J".action = { move-window-down = [ ]; };
      "Mod+Ctrl+K".action = { move-window-up = [ ]; };
      "Mod+Ctrl+L".action = { move-column-right = [ ]; };

      "Mod+Home".action      = { focus-column-first = [ ]; };
      "Mod+End".action       = { focus-column-last = [ ]; };
      "Mod+Ctrl+Home".action = { move-column-to-first = [ ]; };
      "Mod+Ctrl+End".action  = { move-column-to-last = [ ]; };

      # Workspaces (relative)
      "Mod+Page_Down".action      = { focus-workspace-down = [ ]; };
      "Mod+Page_Up".action        = { focus-workspace-up = [ ]; };
      "Mod+U".action              = { focus-workspace-down = [ ]; };
      "Mod+I".action              = { focus-workspace-up = [ ]; };
      "Mod+Ctrl+Page_Down".action = { move-column-to-workspace-down = [ ]; };
      "Mod+Ctrl+Page_Up".action   = { move-column-to-workspace-up = [ ]; };
      "Mod+Ctrl+U".action         = { move-column-to-workspace-down = [ ]; };
      "Mod+Ctrl+I".action         = { move-column-to-workspace-up = [ ]; };

      # Columns
      "Mod+BracketLeft".action  = { consume-or-expel-window-left = [ ]; };
      "Mod+BracketRight".action = { consume-or-expel-window-right = [ ]; };
      "Mod+Comma".action        = { consume-window-into-column = [ ]; };
      "Mod+Period".action       = { expel-window-from-column = [ ]; };

      "Mod+R".action       = { switch-preset-column-width = [ ]; };
      "Mod+Shift+R".action = { switch-preset-column-width-back = [ ]; };

      "Mod+F".action       = { maximize-column = [ ]; };
      "Mod+Shift+F".action = { fullscreen-window = [ ]; };
      "Mod+M".action       = { maximize-window-to-edges = [ ]; };

      "Mod+C".action      = { center-column = [ ]; };
      "Mod+Ctrl+C".action = { center-visible-columns = [ ]; };

      "Mod+Minus".action = { set-column-width = "-10%"; };
      "Mod+Equal".action = { set-column-width = "+10%"; };

      "Mod+Shift+Minus".action = { set-window-height = "-10%"; };
      "Mod+Shift+Equal".action = { set-window-height = "+10%"; };

      "Mod+Alt+Space".action      = { toggle-window-floating = [ ]; };
      "Mod+Alt+Ctrl+Space".action = { switch-focus-between-floating-and-tiling = [ ]; };

      # Screenshots
      "Print".action      = sh "noctalia msg screenshot-region";
      "Ctrl+Print".action = { screenshot-screen = [ ]; };
      "Alt+Print".action  = sh "noctalia msg screenshot-fullscreen";

      # System
      "Mod+Escape" = { allow-inhibiting = false; action.toggle-keyboard-shortcuts-inhibit = [ ]; };
      "Ctrl+Alt+Delete".action = sh "noctalia msg panel-toggle session";
      "Mod+Shift+P".action     = { power-off-monitors = [ ]; };
    } // workspaceBinds;
  };

  # ── Fallback ───────────────────────────────────────────────────────────
  # If niri-flake rejects a newer option (background-effect, spawn-sh,
  # place-within-backdrop, ...), the simplest reproducible escape hatch is to
  # drop `programs.niri.settings` above and ship the KDL verbatim instead:
  #
  #   programs.niri.config = builtins.readFile ./config.kdl;
  #
  # (or, with plain home-manager: xdg.configFile."niri/config.kdl".source = ./config.kdl;)
}
