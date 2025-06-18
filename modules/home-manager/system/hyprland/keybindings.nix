{ config, ... }:
let
  playerctl = "${config.services.playerctld.package}/bin/playerctl";
  volumectl = "volumectl";
  lightctl = "lightctl";
  uwsm = "uwsm app --";
  screenshotsDir = "~/Pictures/Screenshots";
in
{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      bind=$mod, R, submap, resize

      submap=resize
      binde=,h,resizeactive,-200 0
      binde=,j,resizeactive,0 200
      binde=,k,resizeactive,0 -200
      binde=,l,resizeactive,200 0

      binde=$mod, h, resizeactive, -50 0
      binde=$mod, j, resizeactive, 0 50
      binde=$mod, k, resizeactive, 0 -50
      binde=$mod, l, resizeactive, 50 0

      bind=,escape,submap,reset
      bind=$mod, R, submap, reset

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

      bindl = [
        ", XF86AudioPlay, exec, ${playerctl} play-pause"
        "$mod, XF86AudioPlay, exec, ${playerctl} --player=spotify play-pause"
        ", XF86AudioMute, exec, ${volumectl} toggle-mute"
        ", XF86AudioMicMute, exec, ${volumectl} -m toggle-mute"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, ${volumectl} -u up"
        ", XF86AudioLowerVolume, exec, ${volumectl} -u down"
        ", XF86AudioPrev, exec, ${playerctl} previous"
        ", XF86AudioNext, exec, ${playerctl} next"
        "$mod, XF86AudioPrev, exec, ${playerctl} --player=spotify previous"
        "$mod, XF86AudioNext, exec, ${playerctl} --player=spotify next"
        ", XF86MonBrightnessUp, exec, ${lightctl} up"
        ", XF86MonBrightnessDown, exec, ${lightctl} down"
      ];

      bind = [
        "$mod, Space, exec, pkill rofi || ${uwsm} rofi -show drun -show-icons"
        "$mod+Alt, Space, exec, pkill rofi || ${uwsm} rofi -show ssh -theme ssh.rasi"
        # "$mod, \\, exec, pkill rofi || cliphist list | rofi -dmenu -theme cliphist.rasi | cliphist decode | wl-copy"
        "$mod, backslash, exec, kitty --class clipse -e clipse"
        "$mod, P, exec, pkill rofi || rofi-rbw --selector-args=\"-theme rbw.rasi\""
        "$mod, E, exec, pkill rofi || rofimoji"
        "$mod, E, exec, pkill rofi || rofi -show calc -modi calc -no-show-match -no-sort"
        "$mod, Return, exec, ${uwsm} kitty"
        "$mod, semicolon, exec, ${uwsm} google-chrome-stable --profile-directory='Default'"
        "$mod+Alt, semicolon, exec, ${uwsm} google-chrome-stable --profile-directory='Profile 1'"
        "$mod, Q, exec, ~/.local/bin/powermenu.sh | rofi -dmenu -i -theme powermenu.rasi | ~/.local/bin/powermenu.sh"
        "$mod+Alt, Q, exit,"
        "$mod, M, exec, hyprctl keyword general:layout \"master\""
        "$mod, D, exec, hyprctl keyword general:layout \"dwindle\""
        ", Print,exec, grimblast --freeze save output - | satty --filename - --output-filename ${screenshotsDir}/$(date '+%Y%m%d-%H:%M:%S').png"
        "SHIFT, Print, exec, grimblast --freeze save area - | satty --filename - --output-filename ${screenshotsDir}/$(date '+%Y%m%d-%H:%M:%S').png"
        "$mod, Print, exec, ~/.local/share/recordmenu.sh | rofi -dmenu -i -theme recordmenu.rasi | ~/.local/share/recordmenu.sh"
        "$mod, V, togglefloating,"
        "$mod, B, pin,"
        "$mod, F, fullscreen"
        "$mod, C, killactive,"
        "$mod+Alt, P, pseudo, # dwindle"
        "$mod, O, togglesplit, # dwindle"
        "$mod, T, togglegroup,"
        "$mod, Y, changegroupactive, f"
        "$mod, U, moveoutofgroup,"
        "$mod, I, moveintogroup, r"
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
        "$mod+Alt, h, movewindow, l"
        "$mod+Alt, j, movewindow, u"
        "$mod+Alt, k, movewindow, d"
        "$mod+Alt, l, movewindow, r"
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
        "$mod, S, togglespecialworkspace, magic"
        "$mod+Alt, S, movetoworkspace, special:magic"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];
    };
  };
}
