#!/bin/sh

mode="$1"

case $mode in
  "region")
    grim -g "$(slurp)" - | wl-copy
    ;;
  "window")
    grim -o eDP-1
    ;;
  *)
    echo >&2 "Unsupported command"
    exit 1
;;
esac


