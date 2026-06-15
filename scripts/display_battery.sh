#!/bin/sh
battery="/sys/class/power_supply/BAT0"
status="$(cat "$battery/status")"
capacity="$(cat "$battery/capacity")"

if   [ "$status" = "Charging" ]; then icon="󰂄"
elif [ "$capacity" -lt 15 ]; then icon="󰁺" 
elif [ "$capacity" -lt 40 ]; then icon="󰁼"
elif [ "$capacity" -lt 60 ]; then icon="󰁿" 
elif [ "$capacity" -lt 90 ]; then icon="󰂁"
else icon="󰁹" 
fi

printf "%s %s%%" "$icon" "$capacity"
