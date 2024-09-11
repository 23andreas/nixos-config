#!/usr/bin/env bash

# Define the options for the Rofi menu
options="  Record screen\n  Record selection\n  Record window\n  Record GIF\n󰻃  Stop"

chosen=$( echo -e "$options" | fuzzel --dmenu --lines 5 --anchor top-left --width 22 --horizontal-pad 20 --inner-pad 5 --font "monospace:weight=bold:size=10" | awk '{$1=""; print tolower($0)}' | sed 's/^ *//')

# Execute the appropriate command based on the choice
case "$chosen" in
    "record screen")
        record screen
        ;;
    "record selection")
        record area
        ;;
    "record window")
        record window
        ;;
    "record gif")
        record gif
        ;;
    "stop")
        record stop
        ;;
    *)
        echo "No valid option selected."
        ;;
esac

