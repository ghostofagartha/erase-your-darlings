# Ruby's account: a second user on Phantom with her own GNOME desktop.
#
# Install: save as /persist/etc/nixos/system/ruby.nix and add ./system/ruby.nix
# to the imports list in configuration.nix (then `git add system/ruby.nix`).
#
# Her photos and wallpaper are deliberately NOT part of this config. They live in
# her home (/persist/home/ruby/Pictures), so they never enter git or the
# world-readable /nix/store, and a missing photo can never break a rebuild.
{ config, lib, pkgs, ... }:

let
  fullName = "Ruby";
  signedBy = "Nigga"; # <- change this before you gift it

  # Shown once, on her first login. REWRITE IT IN YOUR OWN WORDS.
  # Plain text only. Do not type a dollar sign followed by a curly brace, or two
  # apostrophes in a row, inside it. Quotes and single apostrophes are fine.
  message = ''
    Hi ${fullName},

    I built this entire operating system just for you.
    Every photo, every crimson shade and every detail is yours.

    Happy birthday, my Ruby!

    Love, ${signedBy}
  '';
  messageFile = pkgs.writeText "ruby-welcome.txt" message;

  welcome = pkgs.writeShellScript "ruby-welcome" ''
    marker="$HOME/.local/state/ruby-welcome-shown"
    [ -e "$marker" ] && exit 0
    mkdir -p "$(dirname "$marker")"
    if ${pkgs.zenity}/bin/zenity --info --no-markup --width=420 \
         --title="For ${fullName}" --text="$(cat ${messageFile})"; then
      touch "$marker"
    fi
  '';

  # Picks a random photo from ~/Pictures/Us and makes it the wallpaper.
  rotateWallpaper = pkgs.writeShellScript "rotate-wallpaper" ''
    dir="$HOME/Pictures/Us"
    f=$(${pkgs.findutils}/bin/find "$dir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) 2>/dev/null | ${pkgs.coreutils}/bin/shuf -n1)
    [ -n "$f" ] || exit 0
    f=''${f// /%20}
    ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/background/picture-uri "'file://$f'"
    ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/background/picture-uri-dark "'file://$f'"
  '';
in
{
  warnings = lib.optional (signedBy == "YOUR NAME")
    "ruby.nix: signedBy is still the placeholder YOUR NAME. Set it before gifting.";

  # ---------- Her account ----------
  # mutableUsers = false in your config, so the password must be declarative.
  # Create the hash file BEFORE the first switch (see the commands in the reply).
  users.users.ruby = {
    isNormalUser = true;
    uid = 1001; # fixed, so file ownership under /persist stays stable
    description = fullName;
    extraGroups = [ "networkmanager" "audio" "video" "wheel" ]; # no wheel = no sudo
    hashedPassword = "$6$0.3aFwiONaoB/I/t$izDNGru7SWDbzcouG7hn8q6JEEqt.3L8MvzoIgEMCTfkGHZ4I.c6B80JdFvT.oJ10tnmlfM16LF2MMirj7uve1";
  };

  # ---------- Her desktop (a GNOME session, selectable in SDDM) ----------
  services.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  # ---------- Keep her whole home across reboots (impermanence) ----------
  # Merges with the list in system/persistence.nix.
  environment.persistence."/persist".directories = [
    { directory = "/home/ruby"; user = "ruby"; group = "users"; mode = "0700"; }
  ];

  # ---------- Her home (home-manager) ----------
  home-manager.users.ruby = {
    home.stateVersion = config.system.stateVersion;

    home.packages = with pkgs; [
      firefox
      libreoffice
      vlc
      gnome-tweaks
      obs-studio
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "red"; # GNOME 47+; the CSS below turns it into crimson
        show-battery-percentage = true;
      };
      "org/gnome/desktop/background" = {
        # Put a crimson wallpaper here yourself; the rotation below takes over later.
        picture-uri = "file:///home/ruby/Pictures/wallpaper.jpg";
        picture-uri-dark = "file:///home/ruby/Pictures/wallpaper.jpg";
        picture-options = "zoom";
      };
      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Console.desktop"
          "libreoffice-startcenter.desktop"
          "vlc.desktop"
          "org.gnome.Settings.desktop"
        ];
      };
    };

    # Crimson instead of GNOME's stock red (libadwaita apps, then GTK3 apps).
    xdg.configFile."gtk-4.0/gtk.css".text = ''
      @define-color accent_bg_color #a50e24;
      @define-color accent_color #e8465c;
      @define-color accent_fg_color #ffffff;
    '';
    xdg.configFile."gtk-3.0/gtk.css".text = ''
      @define-color theme_selected_bg_color #a50e24;
      @define-color theme_selected_fg_color #ffffff;
    '';

    home.file."Read-me-first.txt".text = ''
      ${fullName},

      If you found this file, you read the small print.
      This whole system was made for you, with love.
    '';

    # Terminal greeting with her name.
    programs.bash.enable = true;
    programs.bash.initExtra = "fastfetch";
    programs.fastfetch = {
      enable = true;
      settings = {
        logo.source = "nixos_small";
        modules = [
          "title"
          { type = "custom"; format = "Made with love, just for ${fullName}"; }
          "os"
          "shell"
          "uptime"
        ];
      };
    };

    # Welcome popup, once, on her first login.
    xdg.configFile."autostart/ruby-welcome.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Welcome
      Exec=${welcome}
      Terminal=false
      X-GNOME-Autostart-Delay=5
    '';

    # New photo wallpaper every 30 minutes.
    systemd.user.services.rotate-wallpaper = {
      Unit.Description = "Rotate wallpaper through our photos";
      Service = {
        Type = "oneshot";
        Environment = [ "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus" ];
        ExecStart = "${rotateWallpaper}";
      };
    };
    systemd.user.timers.rotate-wallpaper = {
      Unit.Description = "Rotate wallpaper timer";
      Timer = { OnBootSec = "1min"; OnUnitActiveSec = "30min"; };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
