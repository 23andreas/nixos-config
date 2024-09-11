#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | fuzzel --dmenu --lines 5 --width 10 --horizontal-pad 20 --inner-pad 5 --font "sans-serif:weight=normal:size=13" | awk '{print tolower($2)}' )

case $op in
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
                hyprlock
                ;;
        logout)
                hyprctl dispatch exit
                ;;
esac

