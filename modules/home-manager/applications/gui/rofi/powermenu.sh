#!/usr/bin/env bash

# If input is being piped in, read the selected option
if [ -p /dev/stdin ]; then
  read -r op
  action=$(echo "$op" | awk '{print tolower($2)}')

  case "$action" in
    poweroff|reboot|suspend)
      systemctl "$action"
      ;;
    lock)
      hyprlock
      ;;
    logout)
      hyprctl dispatch exit
      ;;
  esac
else
  # Otherwise, just output the menu options
  echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout"
fi

