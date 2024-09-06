{ config, ... }:
let
  playerctl = "${config.services.playerctld.package}/bin/playerctl";
in
{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      bind=$mod, R, submap, resize

      # will start a submap called "resize"
      submap=resize

      # sets repeatable binds for resizing the active window
      binde=,h,resizeactive,-200 0
      binde=,j,resizeactive,0 200
      binde=,k,resizeactive,0 -200
      binde=,l,resizeactive,200 0

      binde=$mod, h, resizeactive, -50 0
      binde=$mod, j, resizeactive, 0 50
      binde=$mod, k, resizeactive, 0 -50
      binde=$mod, l, resizeactive, 50 0

      # use reset to go back to the global submap
      bind=,escape,submap,reset
      bind=$mod, R, submap, reset

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset
    '';

    settings = {
      general = {
        "$mod" = "SUPER";
      };

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # l = locked (works with lockscreen etc)
      bindl = [
        # media controls
        ", XF86AudioPlay, exec, ${playerctl} play-pause"
        ", XF86AudioPrev, exec, ${playerctl} previous"
        ", XF86AudioNext, exec, ${playerctl} next"

        # holding mod with media controls targets spotify
        "$mod, XF86AudioPlay, exec, ${playerctl} --player=spotify play-pause"
        "$mod, XF86AudioPrev, exec, ${playerctl} --player=spotify previous"
        "$mod, XF86AudioNext, exec, ${playerctl} --player=spotify next"

        # volume
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      # le = locked, repeat
      bindle = [
        # volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
      ];

      bind = [
        "$mod, Space, exec, pgrep walker && pkill walker || walker"
        "$mod, Return, exec, kitty"
        "$mod, semicolon, exec, google-chrome-stable --profile-directory='Default'"
        "$mod+Alt, semicolon, exec, google-chrome-stable --profile-directory='Profile 1'"
        # "$mod, E, exec, nautilus"
        "$mod+Alt, M, exit,"

        "$mod, V, togglefloating,"
        "$mod, B, pin,"
        "$mod, F, fullscreen"
        "$mod, C, killactive,"

        "$mod, P, pseudo, # dwindle"
        "$mod, O, togglesplit, # dwindle"

        #GROUPS
        "$mod, T, togglegroup,"
        "$mod, Y, changegroupactive, f"
        "$mod, U, moveoutofgroup,"
        "$mod, I, moveintogroup, r"

        # Move focus with mainMod + arrow keys
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        # Move windows
        "$mod+Alt, h, movewindow, l"
        "$mod+Alt, j, movewindow, u"
        "$mod+Alt, k, movewindow, d"
        "$mod+Alt, l, movewindow, r"

        # Switch workspaces with mainMod + [0-9]
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

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mod+Alt, 1, movetoworkspacesilent, 1"
        "$mod+Alt, 2, movetoworkspacesilent, 2"
        "$mod+Alt, 3, movetoworkspacesilent, 3"
        "$mod+Alt, 4, movetoworkspacesilent, 4"
        "$mod+Alt, 5, movetoworkspacesilent, 5"
        "$mod+Alt, 6, movetoworkspacesilent, 6"
        "$mod+Alt, 7, movetoworkspacesilent, 7"
        "$mod+Alt, 8, movetoworkspacesilent, 8"
        "$mod+Alt, 9, movetoworkspacesilent, 9"
        "$mod+Alt, 0, movetoworkspacesilent, 10"

        # Scratchpad
        "$mod, S, togglespecialworkspace, magic"
        "$mod+Alt, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];
    };
  };
}
