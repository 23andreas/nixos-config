{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 2;
      gaps_out = 4;
      border_size = 2;

      # "col.active_border" = "rgb(f5e0dc)";
      "col.active_border" = "$green";
      # "col.inactive_border" = "0x00000000";

      border_part_of_window = false;
      no_border_on_floating = false;
    };

    master = {
      no_gaps_when_only = 1;
    };

    dwindle = {
      no_gaps_when_only = 1;
    };

    windowrulev2 = [
      "move 0 0,title:^(is sharing your screen)(.*)$"
    ];

    decoration = {
      rounding = 2;
      drop_shadow = true;
    };

    group = {
      "col.border_active" = "$red";
      groupbar = {
        enabled = false;
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
    };

    render = {
      direct_scanout = true;
    };

    input = {
      numlock_by_default = true;
    };

    # windowrulev2 = [
    #   "workspace 1,^(Slack)$"
    #   "workspace 9,^(1Password)$"
    #   "workspace 0,(Spotify)"
    # ];

    exec-once = [
      "hash dbus-update-activation-environment 2>/dev/null &"
      "dbus-update-activation-environment --systemd &"
      "walker --gapplication-service"
      "waybar &"
      "swaync &"
      "hyprpaper &"
      "[workspace 8 silent] todoist-electron"
      "[workspace 9 silent] 1password"
      "[workspace 10 silent] spotify"
    ];
  };
}