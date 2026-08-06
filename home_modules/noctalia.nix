{ inputs, ...}:

{
  programs.noctalia = {
    enable = true;
    settings = {
      config_version = 12;
      recommendedServices.enable = true;

      audio = {
        enable_sounds = true;
      };

      backdrop = {
        enabled = true;
      };

      bar = {
        default = {
          capsule = true;
          capsule_group = [];
          center = [ "notifications" "clock" "battery" ];
          end = [ "tray" "network" "bluetooth" "volume" "session" ];
          start = [ "control-center" "workspaces" "sysmon" ];
        };
      };

      brightness = {
        minimum_brightness = 0.099999997764825821;
      };

      idle = {
        behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
        behavior = {
          lock = {
            action = "lock";
            enabled = false;
            timeout = 300.0;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            enabled = false;
            timeout = 600.0;
          };
          screen-off = {
            action = "screen_off";
            enabled = false;
            timeout = 330.0;
          };
        };
      };

      location = {
        auto_locate = true;
      };

      lockscreen = {
        enabled = true;
        desktop_capture = true;
      };

      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@eDP-1"
          "lockscreen-widget-0000000000000001"
          "lockscreen-widget-0000000000000002"
          "lockscreen-widget-0000000000000003"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "lockscreen-login-box@eDP-1" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 960.0;
            cy = 842.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };
          "lockscreen-widget-0000000000000001" = {
            box_height = 96.0;
            box_width = 800.0;
            cx = 960.0;
            cy = 1020.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "audio_visualizer";
            settings = {
              bands = 32;
              show_when_idle = true;
            };
          };
          "lockscreen-widget-0000000000000002" = {
            box_height = 128.0;
            box_width = 224.0;
            cx = 144.0;
            cy = 987.99993896484375;
            output = "eDP-1";
            rotation = -0.0;
            type = "sysmon";
            settings = {
              stat = "cpu_usage";
              stat2 = "cpu_temp";
            };
          };
          "lockscreen-widget-0000000000000003" = {
            box_height = 112.0;
            box_width = 240.0;
            cx = 1768.0;
            cy = 991.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "clock";
          };
        };
      };

      nightlight = {
        enabled = true;
      };

      osd = {
        position = "top_center";
      };

      shell = {
        clipboard_confirm_clear_history = false;
        panel_anchor_bar = "default";
        password_style = "random";
        polkit_agent = true;
        screen_time_enabled = true;
        launcher = {
          app_grid = true;
          compact = true;
        };
        screen_corners = {
          size = 28;
        };
      };

      theme = {
        builtin = "Rosé Pine";
        templates = {
          enable_builtin_templates = false;
          enable_community_templates = false;
        };
      };

      wallpaper = {
        enabled = true;
        transition_on_startup = true;
        default = {
          path = "/home/aori/Pictures/Wallpapers/Bike_Wallpaper18.jpg";
        };
        last = {
          path = "/home/aori/Pictures/Wallpapers/Bike_Wallpaper18.jpg";
        };
        monitors = {
          "eDP-1" = {
            path = "/home/aori/Pictures/Wallpapers/Bike_Wallpaper18.jpg";
          };
        };
      };

      weather = {
        enabled = false;
      };

      mainBar = {
        "widget.battery" = {
          capsule = true;
          display_mode = "graphic";
        };
      };

      widget.bluetooth.hide_when_no_connected_device = true;
    };
  };
}
