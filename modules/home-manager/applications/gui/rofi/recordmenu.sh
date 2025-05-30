#!/usr/bin/env bash

# ── Called WITH piped input? ───────────────────────────────────────────
if [ -p /dev/stdin ]; then
  # read the single chosen line from stdin
  read -r op

  # strip the icon, trim left space, make lowercase
  choice=$(echo "$op" | awk '{$1=""; print tolower($0)}' | sed 's/^ *//')

  # dispatch
  case "$choice" in
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
      echo "No valid option selected." >&2
      ;;
  esac

# ── Called WITHOUT stdin?  Just print the options ──────────────────────
else
  cat <<EOF
  Record screen
  Record selection
  Record window
  Record GIF
󰻃  Stop
EOF
fi

