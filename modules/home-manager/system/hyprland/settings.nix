{
  wayland.windowManager.hyprland.settings = {
    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };

    general = {
      gaps_in = 3;
      gaps_out = 5;
      border_size = 0;

      no_border_on_floating = false;
    };

    master = {
      orientation = "center";
      slave_count_for_center_master = 0;
      mfact = 0.48;
    };

    dwindle = {
      preserve_split = true;
    };

    windowrulev2 = [
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
      "stayfocused, class:(clipse)"

      "float, class:(com.gabm.satty)"
      "size 1300 800, class:(com.gabm.satty)"

      "move 0 0,title:^(meet.google.com is sharing)(.*)$"
    ];

    decoration = {
      dim_inactive = true;
      dim_strength = 0.17;
    };

    group = {
      "col.border_active" = "$red";
      groupbar = {
        enabled = true;
        font_family = [ "SFProText Nerd Font" ];
        font_size = 10;
        text_color = "$text";
        "col.active" = "$surface0";
        "col.inactive" = "$base";
      };
    };

    animations = {
      bezier = [
        "fluent_decel, 0, 0.2, 0.4, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "easeOutCubic, 0.33, 1, 0.68, 1"
        "easeinoutsine, 0.37, 0, 0.63, 1"
      ];

      animation = [
        "windowsIn, 1, 3, easeOutCubic, popin 30%" # window open
        "windowsOut, 1, 3, fluent_decel, popin 70%" # window close.
        "windowsMove, 1, 2, easeinoutsine, slide" # everything in between, moving, dragging, resizing.

        "windowsIn, 1, 3, easeOutCubic, popin 30%"
        "specialWorkspace,1,5,default,slidefadevert"
      ];
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      middle_click_paste = false;
    };

    render = {
      direct_scanout = true;
    };

    input = {
      repeat_delay = 400;
      numlock_by_default = true;
    };

    exec-once = [
      "dbus-update-activation-environment --systemd &"
      "swaync &"
      "avizo-service &"
      "clipse -listen"
      "[workspace 10 silent] uwsm app -- spotify"
    ];
  };
}
